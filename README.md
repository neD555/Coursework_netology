# Курсовая работа по DevOps Netology

Репозиторий проекта https://github.com/neD555/Coursework_netology

Описание
Проект инфраструктуры сайта в Yandex Cloud с балансировкой мониторингом логированием и снапшотами
Автоматизация через Terraform и Ansible

Инфраструктура
Две ВМ web в разных зонах за L7 ALB
Prometheus и Node Exporter сбор метрик
Grafana публичная подсеть
Elasticsearch и Kibana для логов
Bastion для ssh
VPC с публичными и приватными подсетями
NAT для выхода приватных ВМ
Снапшоты ежедневно хранение 7 дней

Используемые технологии
Terraform
Ansible
Nginx
Prometheus Node Exporter Nginx Log Exporter
Grafana
Elasticsearch Kibana Filebeat
Yandex Cloud

Схема сети
```
           Internet
               |
         Application Load Balancer
               |
        --------------------------
        |                        |
    Web 1 ru central1 a      Web 2 ru central1 b
        |                        |
        -----------Private--------
                    |
        Monitoring Logging
       Prometheus ES Kibana
                    |
                 Bastion
```

Шаги запуска
1 заполнить terraform terraform.tfvars
2 поднять terraform
3 взять alb ip grafana ip kibana ip из outputs
4 обновить ansible inventory.ini при необходимости
5 применить ansible
6 проверить сайт http://ALB_IP grafana http://GRAFANA_IP:3000 kibana http://KIBANA_IP:5601

Скриншоты
Добавь в папку screenshots изображения из Grafana Kibana ALB и сайта после деплоя

Автор neD555

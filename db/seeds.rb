# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Incident.find_or_create_by(title: 'First Incident!', description: 'Code Red!', severity: 2, author: 'joe.schmoe')
Incident.find_or_create_by(title: 'Second Incident', description: 'Nothing too serious', severity: 0, author: 'gurpreet.dhaliwal')
Incident.find_or_create_by(title: 'Third Incident', description: 'Needs a look', severity: 1, author: 'bill.lumbergh')

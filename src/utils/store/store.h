/*
 * <one line to give the program's name and a brief idea of what it does.>
 * Copyright (C) 2018  camilo <email>
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef STORE_H
#define STORE_H

#include <QObject>

namespace Attica
{
	class Provider;
	class Providermanager;
}

class Store : public QObject
{
    Q_OBJECT

public:  
    Store(QObject *parent = nullptr);   
    ~Store();
	
	void searchFor(const QString &query);
	
public slots:
	void providersChanged();
	
private:
	Attica::ProviderManager m_manager;
	// A provider that we will ask for data from openDesktop.org
	Attica::Provider m_provider;
};

#endif // STORE_H

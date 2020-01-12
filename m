Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0C3138583
	for <lists+linux-api@lfdr.de>; Sun, 12 Jan 2020 09:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbgALIVv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 12 Jan 2020 03:21:51 -0500
Received: from mail3.iservicesmail.com ([217.130.24.75]:17665 "EHLO
        mail3.iservicesmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgALIVu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 12 Jan 2020 03:21:50 -0500
IronPort-SDR: TapGAklkdO8kJVbtu570XM4ZFlMnRIy6oUbWEkuwZDrRnakY8PFSjYuBcFQuHi4YdOLZkcZs3g
 ymobQGuJA0Kg==
IronPort-PHdr: =?us-ascii?q?9a23=3AwnHiChTty6TyfaMuF8X460290Npsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6ybBON2/xhgRfzUJnB7Loc0qyK6vumAzJfqszY+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUbgIlvJqkvxh?=
 =?us-ascii?q?fUv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/GfQhsJtkK1Uuhehphxmz4PKZ4GVLuJ+fqTHfdwAWW?=
 =?us-ascii?q?pOQN9dWDJHAo+lc4YPE/YBMvxEoIn9uVQOqAWxBQ+wBO/21DBIgGb606o90+?=
 =?us-ascii?q?QnDw7H3BUsEMwIsH/JqNn4OrseXfywwKTO0D7Nbe5Z2S3l5YbGch4hu++CU7?=
 =?us-ascii?q?Ftf8Xe1UYhGBjIjkmSpIP5Iz+ZyvgBv3ad4uF9VeyvkWknqwRprza12Mgslp?=
 =?us-ascii?q?fGhpgIwV/E8iV5xok1LsC/RU5jf9GkDIVftzuUNotxRMMiTHpluCYhyrIdpZ?=
 =?us-ascii?q?G3ZjQFyJMixxLFa/yHcJGF7xT+X+iSOTd1nGxpdK+9ihqo7EStxPHwWtOq3F?=
 =?us-ascii?q?tFtCZInNnBu3YQ3BLJ8MeHUOFy/kK51DaK0ADc9/9LLFgvlareN54h2rkwlo?=
 =?us-ascii?q?cPsUjbHi/5hkH2jKiOe0Uh4Oeo6uDnYq/4qZ+YK4N5hRvyMropmsOiG+s4PA?=
 =?us-ascii?q?8OX26F9uimyrLj5lX1QLRMjvIojqnUqI7WKdkZq6KjHgNY3Jov5wyhAzqpyt?=
 =?us-ascii?q?gVk3kKIEpAeB2djojpP1/OIOr/Dfe6m1msiClkx+zYMb37DJTNKX7DkLj6cL?=
 =?us-ascii?q?Z98E5T0xY8wcpD6JJTD7ENOvLzWkzpuNzCEhA5KxC0w/rgCNhl0oMeWGSPAr?=
 =?us-ascii?q?KWMa/Lq1CI/uMvLvKSZI8apjn9MeIp5/3wgn8jn18SY62p0YEQaHCiEfQ1a3?=
 =?us-ascii?q?meNH7thMoRVG4SvyIgQ+Hwzl6PSzheYzC1Ra1v3DwjDJOaCtL7S5ygmvS+2y?=
 =?us-ascii?q?G0VslOa3xLEE+LF3jodIWfUfwkZyebI8snmTsBA+uPUYgkgCmjqALgg4VgKO?=
 =?us-ascii?q?WcrjUVqZ/5y99z6MXTjhs5szdzCoKd0DfeHClPgmoUSmpvj+hEqktnxwLYif?=
 =?us-ascii?q?B1?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HrAgDD1RpelyMYgtkUBjMYGgEBAQE?=
 =?us-ascii?q?BAQEBAQMBAQEBEQEBAQICAQEBAYFoBAEBAQELAQEBGggBgSWBTVIgEpNQgU0?=
 =?us-ascii?q?fg0OLY4EAgx4VhgcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQE?=
 =?us-ascii?q?BAQEFBAEBAhABAQEBAQYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAE?=
 =?us-ascii?q?OAVODBIJLAQEzhVCYKQGNBA0NAoUdgj4ECoEJgRojgTYBjBgagUE/gSMhgis?=
 =?us-ascii?q?IAYIBgn8BEgFsgkiCWQSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkU?=
 =?us-ascii?q?PgQmIA4ROgX2jN1d0AYEecTMagiYagSBPGA2IG44tQIEWEAJPjFuCMgEB?=
X-IPAS-Result: =?us-ascii?q?A2HrAgDD1RpelyMYgtkUBjMYGgEBAQEBAQEBAQMBAQEBE?=
 =?us-ascii?q?QEBAQICAQEBAYFoBAEBAQELAQEBGggBgSWBTVIgEpNQgU0fg0OLY4EAgx4Vh?=
 =?us-ascii?q?gcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQEFBAEBAhABA?=
 =?us-ascii?q?QEBAQYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVODBIJLAQEzh?=
 =?us-ascii?q?VCYKQGNBA0NAoUdgj4ECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8BEgFsg?=
 =?us-ascii?q?kiCWQSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2jN?=
 =?us-ascii?q?1d0AYEecTMagiYagSBPGA2IG44tQIEWEAJPjFuCMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,424,1571695200"; 
   d="scan'208";a="304029613"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 12 Jan 2020 09:20:41 +0100
Received: (qmail 24765 invoked from network); 12 Jan 2020 05:00:23 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-api@vger.kernel.org>; 12 Jan 2020 05:00:23 -0000
Date:   Sun, 12 Jan 2020 06:00:18 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-api@vger.kernel.org
Message-ID: <26080795.460899.1578805223189.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.


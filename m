Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DC833D914
	for <lists+linux-api@lfdr.de>; Tue, 16 Mar 2021 17:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhCPQVZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Mar 2021 12:21:25 -0400
Received: from mx2.veeam.com ([64.129.123.6]:37602 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236005AbhCPQU5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 16 Mar 2021 12:20:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 6E3B1423B1;
        Tue, 16 Mar 2021 12:20:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1615911641; bh=jLAgNcD2DJOjyZ+mD0RxHQvUGgZqWTg/KE7NBOdQFlQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=wwHTFgR/vL1gEZgdwRRVhF+wN+ILK5uMR49msGIAFATtXbcL5Kazer7Z9dB+sbg7A
         NELxLyzdTQOZalnP26xTGOnxmGA/TN0yk7Qc/2UVVz0Cx/g5zpCE91BoSl63hTL9Sn
         GDcdvZQFeOiWVvppJXfae3rXE6MKSAu1lnVk4GnQ=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIzq8baaiU89kMOlegDppP098D0QqxwCGasrIZp8gcWBNpEex/hu4ObYvvJgsyKoxzOj9Dtt1n3rpm0DRIuosnYTraBEo6ViKnE/aDdirhPA/SRqC+zGdejcKN7oGJQaaJ958BjB3jUpWeh3dPHte3zHCSn2vJ85luB7WTsSRJz6gJj1WRifElRny/snHLHPUEr0WykSAAqYLWn0YuRIgKJ2V3+kSOlkNqEMXTDm1eSQHQVpqypcLCz3C5i02+CXtPztSBKUTxVEpalPCZDxmjJCzKjxtavB5pBIZcci2mgMi9FcV88mu+dXFussoGrGRjhDbguFMrnsw16Ze5pgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLAgNcD2DJOjyZ+mD0RxHQvUGgZqWTg/KE7NBOdQFlQ=;
 b=Gsh7d9L2zRYxIFbbeo1nfDXkgZByxWltQQB2/4z15R85Age6oOU4jGXDCyEy/r0hQR6hMIDjRd7hU0ATslnEk2ZqY4EMyeMcs0EPiIUys7CvHGtEnsCoPvdSXga595Nb7qglloi+STu3s9ijkYKQBPv90GCn6WrYbqYbi5BBGXmvK0ke6YSoqyHepj216xiUXWM48mUYZ8ctkoHcZlrzEVGqx2FNrESshEmvkZiZ2C1SOCODYtFh4//TH0/ML96ZYM8LSsDImGrsADMz7SgT929xh1PQGHwvOpLsMs+35jJiXC+Xt06i24P47BqnBA2I7UsMRNMo0JU0R7bAjqx5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=veeam.com; dmarc=pass action=none header.from=veeam.com;
 dkim=pass header.d=veeam.com; arc=none
Received: from BYAPR14MB2758.namprd14.prod.outlook.com (2603:10b6:a03:dd::14)
 by SJ0PR14MB4774.namprd14.prod.outlook.com (2603:10b6:a03:377::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 16:20:33 +0000
Received: from BYAPR14MB2758.namprd14.prod.outlook.com
 ([fe80::3cc4:bd31:5b40:f77e]) by BYAPR14MB2758.namprd14.prod.outlook.com
 ([fe80::3cc4:bd31:5b40:f77e%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 16:20:32 +0000
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: RE: [PATCH v7 3/3] dm: add DM_INTERPOSED_FLAG
Thread-Topic: [PATCH v7 3/3] dm: add DM_INTERPOSED_FLAG
Thread-Index: AQHXF1a3wWnmou/FMES2DaVQsQhHUKqDOrUAgAIGKICAAYEFAIAAAH8AgAAPajA=
Date:   Tue, 16 Mar 2021 16:20:32 +0000
Message-ID: <BYAPR14MB275852075C4C032E029D0233F56B9@BYAPR14MB2758.namprd14.prod.outlook.com>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-4-git-send-email-sergei.shtepa@veeam.com>
 <20210314093038.GC3773360@infradead.org> <20210315132509.GD30489@veeam.com>
 <20210316152314.GA55391@infradead.org> <20210316152500.GA55711@infradead.org>
In-Reply-To: <20210316152500.GA55711@infradead.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.49.140.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cee9e820-45d1-47cd-d844-08d8e8976c71
x-ms-traffictypediagnostic: SJ0PR14MB4774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR14MB47741CDA44D8FC7487B51FB8F56B9@SJ0PR14MB4774.namprd14.prod.outlook.com>
x-veeam-mmex: True
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e0oEpLFgiQyxG9uR5O9kKg8//sB3pWgsUgCqiD3KfNetP3Z4fZiu08p3rm3Sq+Ndn2H2si0eL8Mnpgd7biBK18QpW3sNjzlVWQddQR6r2HWpYxfUUIxLsvpV3sQ65VIdpYVEnYOayjlUCYre5fPMwPS2co3P9C+JMNl66yq4ADRsQmAuzPuu2y0y/T876jYqn5NtJsZfh6pMqAE2EVH4w+xiaMuBQuDDBpEXMQCSxGWwUjd7hdXQ9+li1VHTIDBR5ipYWEE8EEIKs4ZuES9s9S6aL2q9aohrh1US1L+FePQRAf9RgCaDCrowh0aiL7CJC83NjqNARnEkUu/nCGrFDs2JIOuvRyS0V7dY44Ibii7QmxLg/AF3FYWiEmwYVZaBuYdwYobzDFEpNE4GP2E9vpeX9rVcIuMczgAa+hq8yA1DB0NV4v1IHNUMoAw08qTGcu9GGUiXJ7CmL5QT6fuzNiZnCPRRE8Gi/hK3i6c+C8DKDHeXhNolgKEgcHmYfdNDqvs+Nx8I4nNOXEnfg0i6MRdukSTZM9KVa4eEFBDfNwD6ykBRAemeMg1ItHga3pzR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR14MB2758.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(316002)(186003)(107886003)(66556008)(44832011)(26005)(86362001)(76116006)(6916009)(71200400001)(66946007)(54906003)(7696005)(66476007)(4326008)(8936002)(5660300002)(6506007)(33656002)(2906002)(66446008)(8676002)(64756008)(9686003)(478600001)(55016002)(558084003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?URFQp59IXBqvlSEXsoQ3dAy3cRC5pbZ66yo09ui8GWUfJXhiFAE5ZlfaOwyH?=
 =?us-ascii?Q?FMdJJ/jY27Fw10X35G1bH+Vsgl9uJyOOloPxAVaVszg6DTwzE2CmXpMVWSth?=
 =?us-ascii?Q?7/gHy/TaYvSMFocmcR7/w6Bs43NvDEPszvs6nXlF3w4cYUug6t+ym4q6Vq4v?=
 =?us-ascii?Q?wVILrHDvmMx6E9jw84esYKbcIlqRnr2rxOA2j6wQZPvL/+pg0Z1k2vXmJ1an?=
 =?us-ascii?Q?baFw5D4esFpNwsFS1CmnlYLljbV97xV4JOoQtwlpHa9nhgF8BXfCF/H6lD3A?=
 =?us-ascii?Q?n+LXyLKOgSU/M3B4OXxhf0CXcqI9lyABokT/8eKAn5pOx8GwHYO0x8dDgBKD?=
 =?us-ascii?Q?tEiljS1JiRbJJdBEk6/hCrQnaaKDnvl/B6UhlYHmLhUJha1phuM4RApb+LEt?=
 =?us-ascii?Q?CSmCSaqcXXvOI7JPgI94lvdQZ/XJB3J1JbE6sVaiLvkXEiLbEe5BimICPMuu?=
 =?us-ascii?Q?qSqcx7M1ho7qXN8+/vjc7o9lTPrS39MjBXlo+i+otfkIhfeEJgdD/W0UlmQc?=
 =?us-ascii?Q?wQZM7ODzVQt4PF26UlOvQiBpe3QFlt3L4P61V8k7dEHqFsFdhEyAu/fFA/RY?=
 =?us-ascii?Q?RhSux18j96FEHFSltXQTE4/zZ7AEX6uYwemutw+psH2SEdnkFLrC+/HdE7jl?=
 =?us-ascii?Q?iUck0EwLiakRO6xfeBEBFk3iFWni02tsrvUtwDMt2uHwyoEbK7nEmYFONW/h?=
 =?us-ascii?Q?Xm0IdjZEKJ0Jou+4Wcn4J2qOlSf0KV/z4AY2sjh+/v5T/0p9SZr1GCQ9Twjc?=
 =?us-ascii?Q?+qy0yHYuKQhQVkOGVy/fpRgDJFiYR/rfIQriBwT9Z6rcWCS5qDNn5tGs4nM8?=
 =?us-ascii?Q?OGiGQhsZvF2+9URst6nESKuEnh0zFcIiW57Xs5Dt0thrci4YmvS9Xs2vAOEJ?=
 =?us-ascii?Q?+vHv7gBxDZXioLuETDXs3PahRXC1KWwp+nJoDkq0AcJRWrAs5Cy0YIfIRZdw?=
 =?us-ascii?Q?Xlej+4vUOTDgirFr7LvoNIllWq0h+xc/ZsuLCfLI0/FQ2VVNqHWFoaO/Jul2?=
 =?us-ascii?Q?XfZ/kqMFqAGcvSazggng8iCFEdmjvmQavuzTUSnkDhTdTwwR+L9yUMbUlLjW?=
 =?us-ascii?Q?nxexLly0vh4npUuihSHAhIkw105JVA71GVQ7OIKlQDt9iDOpT5MlzSZCqvwn?=
 =?us-ascii?Q?O+QVmtIp4GXvvfpIGG19nS9Q37m/WYGq6OaLt5pkQRrL89coLPw9FZoLKJiu?=
 =?us-ascii?Q?cI4l+mT59DuhaLqelNdCk3yaHhOOa5Bq9Dhc9TTUQROvozRB/aXefHLu6MCh?=
 =?us-ascii?Q?ZkDm6BGi/dS6dQM3o3xQL87AODD+I/tblljbwrYmLOuBexi3Ihr1iSR1Qkmv?=
 =?us-ascii?Q?V30=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: veeam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR14MB2758.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee9e820-45d1-47cd-d844-08d8e8976c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 16:20:32.7682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba07baab-431b-49ed-add7-cbc3542f5140
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xq2l7pw+8FYUAYB5xd26YqHZKwlhGSajmijIdJ36ehJiYPj+fQwXwlnnxJmkVqc0PUIEsMg0R8KAxqLVEJ+HkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB4774
Authentication-Results: mx2.veeam.com;
        dkim=pass header.d=veeam.com header.s=mx2 header.b="wwHTFgR/";
        spf=pass (mx2.veeam.com: domain of sergei.shtepa@veeam.com designates 104.47.66.42 as permitted sender) smtp.mailfrom=sergei.shtepa@veeam.com
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks!
I've already started doing something like that.
I'm glad we're thinking in the same direction.

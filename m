Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F32331E757
	for <lists+linux-api@lfdr.de>; Thu, 18 Feb 2021 09:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhBRIPU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Feb 2021 03:15:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29482 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230429AbhBRIMr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Feb 2021 03:12:47 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11I88krU020779;
        Thu, 18 Feb 2021 00:11:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=oVuKizUnS0Qj+lLh289CLBbbJ7kCzBmOwkp3EEcujKU=;
 b=jpnsv9pYxTl5ZDiBzrTk0Vsz0jSDc0swedfaCnRQo0uXgC1gBMeDCkBKam1al9XRaqI8
 zuFhluYBjaYbk9qIz0mMBxS7LiSACE/BSTATWrXmmT2Jdt8sCo1jcGgFvZBLIBLqjY4U
 Fgi/HlbNjQic6B/HtdLWjzkRVDBH/0R18yY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36qvcn9cxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Feb 2021 00:11:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 00:11:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3abRIRt3IRtOxHTRnD2Z5iUeHjOooaCYMDtaODJI1YnD4a7kpByNuJENU7dqgxdXY9749bAT9EKSBh+UMhIpiH6ETWCAf8RNvl+dnhmSIeOW7bvbvrp/xFQ9S6XSGtvrVbK8nLTn0pcBLVUZHIu8EQYKJgCPWLcu+IFwFrOgRG4fsuagcGomo9wbS4RBGaNr1xTt57CcBk6eRhSjQL1cQg+0IBfQfLVA8YR7bkYTol+H40YaV5wyQPFI0MyE1dCXKtqaozAmn0TxzJlDxniccZSI9WOU9V9KJTFOmnLfmlkXoXkJLQ/g71VcHi/p0X5tolj5/dRVi5G1JkY2dAfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVuKizUnS0Qj+lLh289CLBbbJ7kCzBmOwkp3EEcujKU=;
 b=TggWfCnAlOz5+128thYV11z6OS0G5RXZbgWxM4Sa4X/v+WAZd7FGJ2gZI1FmNJf362bHia0owUoK4mTETwxHs4M91n68j408Wh737VbJ0OmAfKfCyUgLznC1Nj6t+aJ3eBXImpkGaYUWXLLa7ewW+LY1nk+pI/hJ/awCN4btAXKvIZceSyxpuvGOc3giYEiuYqxytV1e4r6u0yGDmp/R0AW7/VEHlLT0Jw+f0Q+YZaAE4Ft9gz5dbEUML23hQmBek7oay+rHkKysQgMgWTC6UYC78KL9lh3iJiSi95jXhoeUsUAsbqI1lQvxxAG4kHXQutXjsqxon2TnXBvSzqbFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4710.namprd15.prod.outlook.com (2603:10b6:a03:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 08:11:14 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::8cd0:7956:3c0b:7910]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::8cd0:7956:3c0b:7910%6]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 08:11:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     David Rientjes <rientjes@google.com>
CC:     Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC] Hugepage collapse in process context
Thread-Topic: [RFC] Hugepage collapse in process context
Thread-Index: AQHXBOTGyS5qDuITxk+obyTeBp1b4KpdkXWA
Date:   Thu, 18 Feb 2021 08:11:13 +0000
Message-ID: <9B5BFA9A-E945-4665-B335-A0B8E36D4463@fb.com>
References: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com>
In-Reply-To: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [24.6.81.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7f18446-82ca-4456-b363-08d8d3e4c26e
x-ms-traffictypediagnostic: SJ0PR15MB4710:
x-microsoft-antispam-prvs: <SJ0PR15MB47104BB793AB6C62EE85F2FBB3859@SJ0PR15MB4710.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0wFDxPt5zfvMNmtEa/4bbH2A8v0GNjBBz6pc/cx248HZphmfsfsRwXQJkulvFN2HD15Rr8prlslTmMkH63BTjhU6MRqeeowZFNYTNk7IHmOXWMAL3sCY4fmUaVl/+Sp/o+pLfJ6c5Mn+uJzrx3lUnOMCbBCveV/O7Z4wzOTKI8DLuRU3343S/RY6hqFIamiWG7FoJpCHyMQZL2MBMlRRcvTD8nsEO+cUVnXqQBKJr3OGV6DywO2LLUjcf6f67jSRe4+vqEdamYkOQRV9Tfvo+0qZyVwlOa15gfXhpwlzm9HrXn/Hq58hNixRbt5TPx7PebWt+0mj3nWVvkqfkO4k+xp1CKG266ty0/GIZtRQHQLlV8DXp6ScAAIRMMG5myoREhF4U4sNYDFqumc/GzddSgFnfiYkPyavQbpGeRl3AS3JveToIksgSfDug+O/JozNJyYWXrOGdX4tG1vowZEiwnQt9Ex6UC+uIWJpcfkDhSkSP2dW9IbRkYVPJ4NoFbXC9uOZdxlH7kMI1rjqr6R8e1hmGWi0QSDUBimkZKuMNNcErRvE46/o3zc0em6jpYRyuOYTyj5PFvGu6pRsPBiNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(33656002)(8676002)(6512007)(8936002)(83380400001)(66946007)(6506007)(478600001)(5660300002)(4326008)(66476007)(66556008)(2906002)(316002)(7416002)(186003)(53546011)(54906003)(2616005)(6916009)(64756008)(26005)(6486002)(66446008)(86362001)(76116006)(36756003)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wRYELqV+CnL5S5VK8V/BDULzWLRmZDGDQqt0q0KmoXyDESdXR+/+fxcJc9dR?=
 =?us-ascii?Q?FdnbdgYpjUl7+z4nsg6CUZMx9RRSQjfwkO6P1iMfjKzoFWTfGggSpWy8kuR+?=
 =?us-ascii?Q?OjdWHbJUgOXQOGE/9DJcAnz2J1H+pVpeFG9rCsNROdNEeJXiDiVdIJmaJo1D?=
 =?us-ascii?Q?LxodE5lhGMvYqlFgVhRQiUFF7fcGpsh4lXo7gXoKIMvBdt8rHzFJ0tQB8D5+?=
 =?us-ascii?Q?pxrh0U32jdiwL8gy/bJH2ad+bIe0eUOgkBCF0/ydIbNyfMa0cE7Bh1vTXu3W?=
 =?us-ascii?Q?yBlMQJcMUH7Gi//ujUpTUSluSKVnYpCMOE6PzF/qg17KxHFVVHtqA7JYNI5J?=
 =?us-ascii?Q?JbmbEByGjn0O6t9blxf35LY2EY6GfkQI1WdG9/wK7WggWbBRVj6C2ntQXn6k?=
 =?us-ascii?Q?Vd++VV/nfO91X3Tk5XW365R5djhkngzbLW7Zjdae0gTpApRSD9JQyRj/R1FF?=
 =?us-ascii?Q?Rmyb2NymKTICK2dobF2F2HSEcV93t/McjkRKiWtJAGWrKigStqFyW4NH7et/?=
 =?us-ascii?Q?QX3Pd20LKaPRx/1cu/fpn7QSmpmBcXGiqbkg8L2L3xz0hsCbO/ubqfdCPAAF?=
 =?us-ascii?Q?RjOa/GxjGMMGyZZr73PwpeYc+n7rgXrDr8hYpbjuvOMKaZOvPivvdSrz12CD?=
 =?us-ascii?Q?yH6PC/DxJRf7wbuQTZgWAItRXVvX7tlrVv5BhzgAt3ftA9SW6Q+BGYIjZ4R3?=
 =?us-ascii?Q?Q1hrUIMk7lmzH0AtkZMOcJDvSbEP7O/R9hiw7YlUsnJCJBV9sey9AMZXMh2g?=
 =?us-ascii?Q?xRNuWfhOyPM00tVO9aGaZZ53mU6P/JskQnRk9AnKfyGakxylGyjUm3avPWAG?=
 =?us-ascii?Q?xd7NwedAIAOSsetIAc8hrl9Q4f0G+/YFiw7VM+KU3sPOcfrd4K/J33H5S6lc?=
 =?us-ascii?Q?Pj5uQtENKjzspWPF+jiKAkjb3DVH0ugjHW9tGiXqq2HsjAWZ1t7h4slwPink?=
 =?us-ascii?Q?WAuFwhYeA2+8iDGEhWABYNXuFP+eY2i35aNSQD4g5o+N6E7cVRMfoctimAML?=
 =?us-ascii?Q?MOrk2dTOeO4Hyp/vqrxnKwWq46W+ZeNpIGIYp03qgHphzw/tv90n9Ya9Ws22?=
 =?us-ascii?Q?KQzhT5uzPOplJkTm/n69JORl3B+5PH7Ah6bUqYPavHMjAe/XKBAJFKAY6Rit?=
 =?us-ascii?Q?FlT0vh4d/cp3XAerpKB9VRm5I3Y+F8mQnFVjLiC7FBkm0M1XpOQPxHQALWEg?=
 =?us-ascii?Q?ZgWbINi6OkQ0bnnCH+InSwDkPh8TZv5bE6KbxGdjqgmPlLBWh+8lotnlQCmR?=
 =?us-ascii?Q?jAIfCOSDtlzy/5brevS0iirb+WsxWhChe4xjZ3vTy5Ay4z3m/8/OM9wjXnha?=
 =?us-ascii?Q?/Hvge4IGUPnO5POxJJzJ0zXv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5335E776C975DA4FB02DFDCA65E3546D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f18446-82ca-4456-b363-08d8d3e4c26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 08:11:14.0004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpS6PCN2wIMwqtNGSdRFB0fWkQPefqoliaknuqMtrOoDeSENmxg9/H3OJ7JxVVwH4HIxReq65RN+Z7hiz91RgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_03:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180067
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Feb 16, 2021, at 8:24 PM, David Rientjes <rientjes@google.com> wrote:
>=20
> Hi everybody,
>=20
> Khugepaged is slow by default, it scans at most 4096 pages every 10s. =20
> That's normally fine as a system-wide setting, but some applications woul=
d=20
> benefit from a more aggressive approach (as long as they are willing to=20
> pay for it).
>=20
> Instead of adding priorities for eligible ranges of memory to khugepaged,=
=20
> temporarily speeding khugepaged up for the whole system, or sharding its=
=20
> work for memory belonging to a certain process, one approach would be to=
=20
> allow userspace to induce hugepage collapse.
>=20
> The benefit to this approach would be that this is done in process contex=
t=20
> so its cpu is charged to the process that is inducing the collapse. =20
> Khugepaged is not involved.
>=20
> Idea was to allow userspace to induce hugepage collapse through the new=20
> process_madvise() call.  This allows us to collapse hugepages on behalf o=
f=20
> current or another process for a vectored set of ranges.
>=20
> This could be done through a new process_madvise() mode *or* it could be =
a=20
> flag to MADV_HUGEPAGE since process_madvise() allows for a flag parameter=
=20
> to be passed.  For example, MADV_F_SYNC.
>=20
> When done, this madvise call would allocate a hugepage on the right node=
=20
> and attempt to do the collapse in process context just as khugepaged woul=
d=20
> otherwise do.

This is very interesting idea. One question, IIUC, the user process will=20
block until all small pages in given ranges are collapsed into THPs. What=20
would happen if the memory is so fragmented that we cannot allocate that=20
many huge pages? Do we need some fail over mechanisms?=20

>=20
> This would immediately be useful for a malloc implementation, for example=
,=20
> that has released its memory back to the system using MADV_DONTNEED and=20
> will subsequently refault the memory.  Rather than wait for khugepaged to=
=20
> come along 30m later, for example, and collapse this memory into a=20
> hugepage (which could take a much longer time on a very large system), an=
=20
> alternative would be to use this process_madvise() mode to induce the=20
> action up front.  In other words, say "I'm returning this memory to the=20
> application and it's going to be hot, so back it by a hugepage now rather=
=20
> than waiting until later."
>=20
> It would also be useful for read-only file-backed mappings for text=20
> segments.  Khugepaged should be happy, it's just less work done by generi=
c=20
> kthreads that gets charged as an overall tax to everybody.

Mixing sync-THP with async-THP (khugepaged) could be useful when there are=
=20
different priorities of THPs. In one of the use cases, we use THP for both=
=20
text and data. The ratio may look like 5x THPs for text, and 2000x THPs for=
=20
data. If the system has fewer than 2005 THPs, we wouldn't wait, but we woul=
d=20
prioritize THPs for text. With this new mechanism, we can use sync-THP for=
=20
the text, and async-THP for the data.=20

Thanks,
Song

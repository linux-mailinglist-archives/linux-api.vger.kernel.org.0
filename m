Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0BC31E9B7
	for <lists+linux-api@lfdr.de>; Thu, 18 Feb 2021 13:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBRMYv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Feb 2021 07:24:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16582 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230100AbhBRJy4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Feb 2021 04:54:56 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11I9mkJb029668;
        Thu, 18 Feb 2021 01:53:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RSnrtu4gD3/aoFHgvVSAJik93t806V4J87UvqLffnzA=;
 b=ebxWn+IayeufyIVgX5TGH2BNPlTUiLKsYA093F3nd6HqL7Unx9Jw6n9XEE556Im5gB80
 fFs0oHsh0RZJOanMaVj3p9tzn2R3n+vnz7BapapVkJsHwFPdXVuQutYKUKo6DjORqiOK
 jJxMjA+FjFaXn8gBpAhPz3zmQo5nBp3Tb80= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36s1jgeu6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Feb 2021 01:53:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 01:53:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DntXJJPhpF60naVBqyABqpXsFpEaQD+kQMhE2+GWnKicFrxXV0IWdOvFyHkp/5Aqj7xHc8leI064g+NzIXG2uFqIiI5LTZLJXoylK3FrCl9NqRdaZtqldCouKhhq2TZnFG4Dic+IozuLClwZJFcGfyisew97posZ3eXWRCKcXgeYt958H5Gkf0oedaO7s2+WW16SaJxSClYGxfUBYdJ9/mwR3+/SiOEXSjJfrgjmd7JaYmmY3/PHTgC67zip+1tqA1oSLd0LRyH7vg3vPl0q8mf/RebIq0Ex9zgT0y+2nefwc6OLBZwHAKQe29gJqRrvNXA2emjpeDlDdhPQ5IZLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSnrtu4gD3/aoFHgvVSAJik93t806V4J87UvqLffnzA=;
 b=cEV65VWQNrsuxbA/393qaM6/aHcBkxW1nzJIArypNbusso7zaTmNBXkH+TXT0NJR9TyqV2mvHWnl73NPr4haRhaKhO9tmztuaJuCxikIoU9ghsT6L9wip0H3OGVIe5i2T7kN5xizdIw/Fw+nXdufCvtET7OlGVO7QncJ/bMoWFA6v1T7+m54qW9mZ7lDagol2PrJVs5SbAt8sYiB1r7EiEO9ZnsQQMGo7HDMzR1EmYN0xZa27zbfDJLv2quE94idgFVCenUxfc1NEpiMXO4zOOGECNJdI71zS57/uvj+WMbFGrPaEN5jDVhismw6LP8csh71ZpTjdyHhpWO1LcSjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3366.namprd15.prod.outlook.com (2603:10b6:a03:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Thu, 18 Feb
 2021 09:53:26 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::8cd0:7956:3c0b:7910]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::8cd0:7956:3c0b:7910%6]) with mapi id 15.20.3846.042; Thu, 18 Feb 2021
 09:53:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     David Rientjes <rientjes@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Chris Kennelly" <ckennelly@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC] Hugepage collapse in process context
Thread-Topic: [RFC] Hugepage collapse in process context
Thread-Index: AQHXBOTGyS5qDuITxk+obyTeBp1b4KpdkXWAgAAH7YCAABSfAA==
Date:   Thu, 18 Feb 2021 09:53:25 +0000
Message-ID: <97A31D94-671B-4400-8114-9039B28E54A7@fb.com>
References: <d098c392-273a-36a4-1a29-59731cdf5d3d@google.com>
 <9B5BFA9A-E945-4665-B335-A0B8E36D4463@fb.com>
 <YC4nx/qChwNdfLmB@dhcp22.suse.cz>
In-Reply-To: <YC4nx/qChwNdfLmB@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [24.6.81.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0e1d282-69d3-4f5a-a2f9-08d8d3f30920
x-ms-traffictypediagnostic: BYAPR15MB3366:
x-microsoft-antispam-prvs: <BYAPR15MB33667603E6A89CBE34183380B3859@BYAPR15MB3366.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wn8iHvQ6AUfoGJt1ziMdt/PPLdJdXB3R1q0z8ux0azxOHteo2XOjjO2hC3CtgwqGQREG6uez19c2CfYDdNkegVk1RMDLcpQmZ8fvJQQKzCpjvqmXLUwzqk8vQ/mdVxbqws4NQ93U4Rc3zAIeZPUq43N3JJbSWwep/AOFnn/ujH59zm1Hx3QV76N+ZkNZTcKx0GsF6ufrposoQNDprwSlXC8XeYw0XYM/iQbUI2itsHdgcM6Jp7NpVXm8fm1zPVJbqu/IaaaLKrl34c8qNfRjeTtE01W6+Ol4WT6XskiKWWZPqUQ0QWiB7MP7KXoOgMx5M5NsWRk9o8O/UXuIMB2o6HgyvqUjwKZmd3+T8eaohP84EsAwHSbNz7/Xws/+uECAeGV7XtGjrOzV2WaWUM78do9+du3SlHyF/is0+F4nVoSPHGu0KaZZNZDX8uKGoB9MOEEnkrqJEDstqlMQtTGJUvaargVlSzt4rzm92/242PETY39TkxXZwM/yoUPpJ+UWxXEVEz/BsAU85g4WiruwDeqN449Ud2WvNEFDS66ouJLWMDSjyr8R6M1HbLqMFVuberPPGJVJlv0CxMtUrYAFQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(366004)(346002)(83380400001)(6486002)(64756008)(5660300002)(66946007)(7416002)(66446008)(76116006)(36756003)(8936002)(33656002)(2906002)(186003)(53546011)(26005)(66476007)(6506007)(8676002)(71200400001)(4326008)(66556008)(6916009)(316002)(6512007)(54906003)(2616005)(86362001)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Cjv59GZcq1L6AoVoS3Kj0zTKS9ftLcWZ0EfTjK9N6oxlBty+iSw5PUGZbMp0?=
 =?us-ascii?Q?NDWNUHR5reBdAYAYDwx4F8DbrCXv00nqix6AJfmIaR4gaqdtgLANegmLXdh9?=
 =?us-ascii?Q?SoKKeR9M4lqMNcUXwtqwIqQT42pMBAAtVPwdC8UfpPPUmi3OXTdL/fHHuZ+A?=
 =?us-ascii?Q?K7Wsl2OrNSSeSLwVVD6e6YemSS9My4Mud/U2ojiR3pmFmPQ1D+pmE6As99RM?=
 =?us-ascii?Q?JKEV2lc1evfQM19F7zoVvxXVsdpqN8XiA1NUAXXboh8HXbeh+0KX58HAEdF/?=
 =?us-ascii?Q?PoEVYgh6OmSPhqfpGn4HWmOYqHNZNNOdSpJlDx2uVjsoP2kL8nHnxGhC4Pwp?=
 =?us-ascii?Q?j9yfkP8mFWRxIlRXJcO1PLvlcR5wRWXt1TOetstMuSGFIOwwO463L/gVPwjm?=
 =?us-ascii?Q?qcFvXIZY1ULiZcs5DOG/GGBJ07BlkuF0Is2npf2ZZ30hJUmYqQwqyUI/FI2J?=
 =?us-ascii?Q?A+yG46WCapxBdpDV0VkS4b2M3yTzw/WK8tFdWtf+38U9e+eVOmbyrUOUj2q5?=
 =?us-ascii?Q?JQZKNW3gNNeU4tq/iMNxLvBBxf34kQ/XG0ppPpHzz/lYXA43VKjP1UshXbxR?=
 =?us-ascii?Q?oQCMq6RKA5sAc6vMPV16JD8p4pBR6YWvSZD55b+FcOKrDpgxlj83bPnQOxr9?=
 =?us-ascii?Q?3ngSg/9fzAuSqCySd9gkj1/z126pdkl2FPhmP7kzrPLV3cCx+9kZvoTcpuDO?=
 =?us-ascii?Q?pHpOQf/QHi3vpFYxUBT00eFQZsIQNkw7kv8PigZkkmVpNVKFLa0F5QA8aggY?=
 =?us-ascii?Q?k+9VXEvhnEK1YqAReeNNKXWJcEAOPJSpz6xH2HQwpW9h6iuHhzQG+rJBNFLs?=
 =?us-ascii?Q?f7QpsYrapWeCKfvS+ns+kIufGPjhyVAC6o11oUBBsah3pD/yEPNJMYUrbplZ?=
 =?us-ascii?Q?CSHNVYlD3v2XKw7x6AB9szzwCbvScbr8wt/W3FC/6r815SQHkMARqHBvM0T4?=
 =?us-ascii?Q?1z5jIrHFR3ed3Iw9j893TRkRSO2vtpIQhepKZlSIt/n82768dV/zLDsjpjPV?=
 =?us-ascii?Q?D81wnksw+Nu198EYDVFs7RosjG+H1+6CQ4if0Z2LhiLq8SkYg2yIzAIurSjj?=
 =?us-ascii?Q?P536M+ZFQtqrBtLkQw4JUcX7tyx/3DzHONU3i/zb/5sQ5QyT+OSpGfxg9ca1?=
 =?us-ascii?Q?egbKMbMUmud8355xByZptdpxQV7pS8M7pu1QnG9/MI4woZZBypSX4oZgRZtN?=
 =?us-ascii?Q?GhoATQQ4h2Jn/hfU8YalFqFbWIBfWdB9wm4d1MMmIGx3O4i2xq3xEQtTZDCF?=
 =?us-ascii?Q?vGuKvHriWDULfeao+TM/Q4RY9mwehOgHNGfxZXy+LvLMWCZq2Ee+dvdNvc2B?=
 =?us-ascii?Q?hHO/zFbPJjTethJzJX/WahER?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F41F54098D73B14CB7B57D5C5CFB35C4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e1d282-69d3-4f5a-a2f9-08d8d3f30920
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 09:53:25.5373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAWRdYgF19NsaJXZNC8sFtZvOg8uDVDAkWg80WfIXXIItSdThShRcIwPwXzK12pCw5SQFvK+mj+xIiPUwnLSHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3366
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_04:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102180085
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Feb 18, 2021, at 12:39 AM, Michal Hocko <mhocko@suse.com> wrote:
>=20
> On Thu 18-02-21 08:11:13, Song Liu wrote:
>>=20
>>=20
>>> On Feb 16, 2021, at 8:24 PM, David Rientjes <rientjes@google.com> wrote=
:
>>>=20
>>> Hi everybody,
>>>=20
>>> Khugepaged is slow by default, it scans at most 4096 pages every 10s. =
=20
>>> That's normally fine as a system-wide setting, but some applications wo=
uld=20
>>> benefit from a more aggressive approach (as long as they are willing to=
=20
>>> pay for it).
>>>=20
>>> Instead of adding priorities for eligible ranges of memory to khugepage=
d,=20
>>> temporarily speeding khugepaged up for the whole system, or sharding it=
s=20
>>> work for memory belonging to a certain process, one approach would be t=
o=20
>>> allow userspace to induce hugepage collapse.
>>>=20
>>> The benefit to this approach would be that this is done in process cont=
ext=20
>>> so its cpu is charged to the process that is inducing the collapse. =20
>>> Khugepaged is not involved.
>>>=20
>>> Idea was to allow userspace to induce hugepage collapse through the new=
=20
>>> process_madvise() call.  This allows us to collapse hugepages on behalf=
 of=20
>>> current or another process for a vectored set of ranges.
>>>=20
>>> This could be done through a new process_madvise() mode *or* it could b=
e a=20
>>> flag to MADV_HUGEPAGE since process_madvise() allows for a flag paramet=
er=20
>>> to be passed.  For example, MADV_F_SYNC.
>>>=20
>>> When done, this madvise call would allocate a hugepage on the right nod=
e=20
>>> and attempt to do the collapse in process context just as khugepaged wo=
uld=20
>>> otherwise do.
>>=20
>> This is very interesting idea. One question, IIUC, the user process will=
=20
>> block until all small pages in given ranges are collapsed into THPs.
>=20
> Do you mean that PF would be blocked due to exclusive mmap_sem? Or is
> there anything else oyu have in mind?

I was thinking about memory defragmentation when the application asks for
many THPs. Say the application looks like

main()
{
	malloc();
	madvise(HUGE);
	process_madvise();
=09
	/* start doing work */
}

IIUC, when process_madvise() finishes, the THPs should be ready. However,=20
if defragmentation takes a long time, the process will wait in process_madv=
ise().

Thanks,
Song


>=20
>> What=20
>> would happen if the memory is so fragmented that we cannot allocate that=
=20
>> many huge pages? Do we need some fail over mechanisms?=20
>=20
> IIRC khugepaged preallocates pages without holding any locks and I would
> expect the same will be done for madvise as well.
> --=20
> Michal Hocko
> SUSE Labs


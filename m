Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD704405CF2
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 20:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhIISqr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Sep 2021 14:46:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45970 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237317AbhIISqq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Sep 2021 14:46:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189Hhtsk016780;
        Thu, 9 Sep 2021 18:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/D7TXA3hpOip0D2y+vQjETw3luOAbcByfN7ROhZGOow=;
 b=kiNlKJhfE+h8zGUIQkVe2hSOLnaH1d83iaPHWq9Jc+urz2cK1crJzluo84/1Jq5wdPql
 4j/i6xm1PLLV8KyF7sx9ViceM48oPGW+pNKcKXcMQMGy3AGV7Zeylt1cHlo88EKyz/A1
 OWtn/N4zLESK2qG1519xe8VSMG9y24PM9zTUDR0sgyegEtp/F7gP5z8mP3FQlf5/0Dp5
 QQ7zULouQ+uI3iQx/7Cosw9Tijax2bjlIbLasBvET4lRdq9RLWXrygZn12FzTjLLnhFs
 0CZT/MJsQPxNW6J1Y5ZeNYp3yRJtb6gqx4Cna22iHd1/vaMKtIRx7AAsKwkxGVOgsbA8 vQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/D7TXA3hpOip0D2y+vQjETw3luOAbcByfN7ROhZGOow=;
 b=CxYJo7ykmJy+AJ8jIaLVrPk7NHfoL7sbOHW5wQzHs6flZrVKym7SwWDqvPg/fYBmKwpv
 ZZQPx1duLtkNvzHjG5uhR71D0rqGCS4d4T2iCAardSxcZ1Siko1LM4bkXXY6/5qZ/iyR
 9eMesSZhhAt74iWNNandgYP8Na4SAwBC/Ls24Z9nIiu5yIGdR48WMPrKXaDXkCe7SyFS
 VV7Fc+B1TpI9O2jBk/QDWIA/nepjxGOCxhwYce79LEVJhKu9wqpvJIRrwF+SBKuu7MwP
 iKkRFHAi8gd9aDek9n5rcP1X0j/961f590DBwRcJqXIBO4/0L3UrirOfkmlupKcSilfZ KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aydrsj6nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 18:45:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189Ib8kl163130;
        Thu, 9 Sep 2021 18:45:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 3axst5v145-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 18:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gihZn54RJGUkaUlYE1Y8VpZklB7Z/f9vM82P9wCV8cZ/Jr73QHunTNe1t5OaIXfRBmE0JyS2/CcyeQB5Tp1T61rYbuj8zPv8rHTSX6s9dE+InrC37Kc1wYlsKjsZZ0oOK1Uv/I33UF/M0rBaoeYKMfnQkWEecwo4a/kma3DJEvfefJrPq5r0iTgcgV0xg5vIn3Q1KzCK424YwNT9fASsqGyejMpnKX701MoXN2lfl3BH8ZTqZxgXJDV50lbrjdm9gNwFgcpKJPp+pwO5E0v5MopFogtQ3l7mkNMiiKEO+tmDBucXItHwejGDCNXjZH6Jix0Y2P9ubk/Vl5fNLSNkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/D7TXA3hpOip0D2y+vQjETw3luOAbcByfN7ROhZGOow=;
 b=JdYgBoDATS4iHonh7WO9ffFuueBIkwtuqLojz1ZlCcfpLYu8oYQdPEixVdfuD4Uj6bHeGykEI3Cgbq3wvVzGnjwfM9MZikf+4iWFqPnlzmZKGCz1pgfMOZ9Okg3K7sr/Ee7Ya+NycHVIUQ1aH/OZkcUNN7wS/INZsu9u/t6sFmYOlHEtunC0l5ss6S2gFvW71QNNUXl4uxNl47geO+JjqFxLw+dx85gb0Sh/atSVkDcnAawjp322Me3s9G5nfLXbsjmXrwekwImDtF+byPIp5H9BevDF7u2OSIg1XkF7omZ5WgNxcgzFp2na8mkoSygu2f6FVyeQgfYx0LbOK5E4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D7TXA3hpOip0D2y+vQjETw3luOAbcByfN7ROhZGOow=;
 b=Y6iWz/QPT7bZM2VrKlWpKvo+iUECWWV2gIsG8GXvFTmNxBNgyJivmHz5AO3lzq9gLwa/+JSyDyOdNpdhFTYnL7XGfwhempO8IreAq3hNNbaynEZmwgFJKFF34Z8VdcKgSEkZ6NNHsmtCw0VE+2faZHROzqOHmHgwI5V0e9YVcyw=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 18:45:29 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 18:45:29 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [RESEND RFC PATCH 1/3] Introduce per thread user-kernel shared
 structure
Thread-Topic: [RESEND RFC PATCH 1/3] Introduce per thread user-kernel shared
 structure
Thread-Index: AQHXpQ4EAwEPTwjbx06EdbuOOXayyqubQN+AgADKu4A=
Date:   Thu, 9 Sep 2021 18:45:29 +0000
Message-ID: <7CB0EABA-CD96-44A0-8767-526C9DC383CB@oracle.com>
References: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
 <1631146225-13387-2-git-send-email-prakash.sangappa@oracle.com>
 <YTmsN78BGKZZLULo@kroah.com>
In-Reply-To: <YTmsN78BGKZZLULo@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86b70c11-8eac-49f8-6914-08d973c1fefd
x-ms-traffictypediagnostic: BY5PR10MB4308:
x-microsoft-antispam-prvs: <BY5PR10MB4308F63D22C28B5015C12DD3E4D59@BY5PR10MB4308.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mN1el/YJesAbn8mX46vnFFZeUC3kJ0AIgmJlsQhtYaPJlyQCqLEIf9DK4Ku/9SYHQ9DMxbVC70noDKQF+if7J7ebHOU+C3uJt4UcOn+tMGZBdU2mM9oTx5D9iaIpaKxtLq1wsds0Zim51+LBgWOF6F5ndRyA13h/UlirX/TuN1THdqkGIyZuvf+8rn9DP5HrxZO3Kj3qL7Gsh4AJG/CYUqozcNW2MYEEP6B5XNqaDC3Fpsu14bJ8+bDAOngmH+ueI4p11QVmT5YDSN5Jcql92joFaKb5ba40ieLBOWo4FMGsbUbHL4FIW0gn6XtEz8ywukBZjqtIWMV9pUjZS+/2pNDbU/J56aKVFzyunTB+P7WyjCk7aJxY8DTfEW3rDP2PBvbq2qJmuitEGh/E8A63uT4NtiCJJ44xAWj4dC/RCOrhiLgYmEImD48K67+QlEmzQBGI43yyYW7VR88n9mH6MqVQw2mT9xOH8MOch6YGYQCly5vMQkG49S0oDjYAgR1L+AdD66Ybc2Y/gpptQA3JCgVrV1maNNub8bnw7rHcqi8o9+MbScbYe+zUIZe0mzjZr0wkLaQTF1peUr2gZ7Nd+s7+fp1oSz/f4zTZmwON46UJ1DN7+1yua7XVQEOXm1C4K9HS1jqRySNGEnQN1pXRrl2tPr02xPHEbSPJk33rjA6V9mTvvOV6OYinYnqvOsH9c4nnMThlYDRpqfwi3b3eQT6CE5WcBdaM02iw46WdidU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(71200400001)(5660300002)(6506007)(38100700002)(2616005)(4326008)(76116006)(316002)(66946007)(66476007)(54906003)(44832011)(64756008)(38070700005)(86362001)(8676002)(36756003)(53546011)(6486002)(6512007)(66556008)(478600001)(66446008)(122000001)(33656002)(2906002)(186003)(6916009)(83380400001)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mOCTKgwtB2cwLq2wOA8U5i3UkcKPLzZqMpN7b2MO0e4e8t7ZfqEfJMvaEGc/?=
 =?us-ascii?Q?EFoLSzAiWzj+rfQIbJqAW6PlXqrPme+ZEAEzpuhCP4DrElqYEDB6YKt2uFe7?=
 =?us-ascii?Q?R2tQskNyH+9XFJy/D4HYRNeyyPXVgwsXAAGrL9OhfRC3jtXicEcaEZ1hDgM6?=
 =?us-ascii?Q?9R2Ax287I1qR2DYwOW9+CWSwCpL8bBu0mIcZV+FYNh95VD+i3UGLIFo8SU6k?=
 =?us-ascii?Q?WHID5pH+yhtjV1tVrREogqVya+xuVX/J9X23zfGbkwsQRHL4wkwTOUzkUJzK?=
 =?us-ascii?Q?XqsMsqCDrsFzFglcgH3ghV6LeUQGK07To6GzCEZqwoSKbv3ljyosRNnrZkY1?=
 =?us-ascii?Q?+5QszdI0KYyFxTqN694gDhAJhwV2Ogw7cqPG9q9N9rN/dzNHPOZymGxfQPzi?=
 =?us-ascii?Q?/8/SzUY4vXV25OVWbaE8yS3lJn4fGI8Vw0Ba3KLx76Ki2YMhkrObheDbu6Dl?=
 =?us-ascii?Q?r5TR4c3FQIN7t7IKQICzzbpY3Q0RfNInqp/BkwV/14b4joYBeogPSxYryFvd?=
 =?us-ascii?Q?REaZiVCtm02T1sWBimhXNXQkYOry+wdIYiRUOs8XYwywhPTM6g+MPmq3ExgX?=
 =?us-ascii?Q?PQdEbzrLojUXEZ2axgk8u0KxpnGlEsZdU1dOfPaPyHlXcLnKuMZxVZQxY1CY?=
 =?us-ascii?Q?PWWTAc1DdPqJnKMGdAHGCpJOzjfyB+5o/wT2hG1NYoYfriXriKXhz1kf50PS?=
 =?us-ascii?Q?WiOrgLGjfDyLvqOAwSB7LRLoqKjbFU2IG4bTNXIXK0VAruftTWqhl75Y02z9?=
 =?us-ascii?Q?1EUhF01yrscGDcJgfvT2n3pfYsgHRSyo+gs76YAmg4/h3ZNgVe9ng9pF7y6H?=
 =?us-ascii?Q?5YoXUJuxnK/ZzH6O0UeTcc8m4pBYDUYJZCTpE3cWqJgj90Qle0KN1KX2lwPt?=
 =?us-ascii?Q?DMj78PYq28gO8xW5dGhpZAVHNldAWEyRIaB1M9GFiybGWsNpCPL6ZZvL9sNQ?=
 =?us-ascii?Q?OJRHqMVtAZokSrtf7TEqMZ111gPK4NjKhdG9m1uJLQBeYe83Yve3cXDx6yGR?=
 =?us-ascii?Q?kdStiJxxIeOx9IUR8TFSH+SAz94hAMIke5ZWyIDOXysu58TtVM1hx1LJ/grc?=
 =?us-ascii?Q?SoRyIYp+4DVkgG4vlPDOnva7IQjiRJkX3iwgpKvZsVO8qhAaiy9lArrfvPZS?=
 =?us-ascii?Q?y6XmI6XHR3iycoaASaIugcwlmu36r7tLWlEZaGIN8V4MemTPElEahCG0/+qt?=
 =?us-ascii?Q?2h9hpIsA92dOuJnEbA8y3Xm3vkzqZNdoyjRLhuZ7aw4RweYK2NAT93lqFX9c?=
 =?us-ascii?Q?rMukzXIEcHxjwkmImnxalL6i3/upqcGQFYZjMKHXTD1EhLW6McA9o/O3T1uC?=
 =?us-ascii?Q?5HpZsHihdl48n6sicUyVY6qq/ISY4r2BdQ9Xr5R0hrho7HoD7ioWUDnwVsNO?=
 =?us-ascii?Q?Gh5Xe8M=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <154ED7E5E5C6C740A96E3E330CB1CBDE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b70c11-8eac-49f8-6914-08d973c1fefd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 18:45:29.2369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUPEUzesHNPSApbS0ipP9HL7GRoPA0ZgYYTsBdeeO91msJh5UC6BSzAmui7nxUPbzma0dkUP6pUz4P7mlPuEGONYstVDRLjuwK3BWoBjWuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090113
X-Proofpoint-GUID: 2TKxnrCUKu0BJnGzcSuPmBAiqRh504KX
X-Proofpoint-ORIG-GUID: 2TKxnrCUKu0BJnGzcSuPmBAiqRh504KX
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Sep 8, 2021, at 11:39 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> On Wed, Sep 08, 2021 at 05:10:23PM -0700, Prakash Sangappa wrote:
>> A structure per thread is allocated from a page that is shared mapped
>> between user space and kernel as means for faster communication. This wi=
ll
>> facilitate sharing information, Ex: per thread stats shared between kern=
el
>> and user space, that can be read by applications without the need for
>> making frequent system calls in latency sensitive code path.
>>=20
>> A new system call is added, which will allocate the shared structure and
>> return its mapped user address. Multiple such structures will be allocat=
ed
>> on a page to accommodate requests from different threads of a multithrea=
ded
>> process. Available space on a page is managed using a bitmap. When a thr=
ead
>> exits, the shared structure is freed and can get reused for another thre=
ad
>> that requests the shared structure. More pages will be allocated and use=
d
>> as needed based on the number of threads requesting use of shared
>> structures. These pages are all freed when the process exits.
>>=20
>> Each of these shared structures are rounded to 128 bytes. Available spac=
e
>> in this structure can be used to accommodate additional per thread stats=
,
>> state etc as needed. In future, if more space beyond 128 bytes, is
>> needed, multiple such shared structures per thread could be allocated an=
d
>> managed by the kernel. Although, space in shared structure for sharing a=
ny
>> kind of stats or state should be sparingly used. Therefore shared struct=
ure
>> layout is not exposed to user space. the system call will return the
>> mapped user address of a specific member or nested structure within the
>> shared structure corresponding to stats requested, This would allow futu=
re
>> enhancements/changes without breaking the API.
>>=20
>> Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
>=20
> Where is the Documentation/ABI/ entries for this new user/kernel abi
> that you are creating and must maintain for the next 20+ years?
=20

I can include the documentation in subsequent version of patchset.

The shared structure size and layout will not be exposed to user space.
The ABI details of supported struct members will be in uapi/linux/task_shar=
ed.h.
Man page for the system call will need to be added.

Thanks,
>=20
> thanks,
>=20
> greg k-h


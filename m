Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4F4158649
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2020 00:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBJXpS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 18:45:18 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:55179 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgBJXpR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 18:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581378317; x=1612914317;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QvNE01t6l1CoHa6KNfsmI1cvcVYuDyg0IXX2hTJSAnE=;
  b=CF/mJk5zY0c9pGqUgfjwTv1RbvTznXKYoH0GRwmJfLvpiYZErdBNqChz
   eZeamEHYznhCBKz3Vl3Ft7QZLeyBxlOlnzKsah+bsDtscztH0Ta275PzF
   bwNey/CUtz9te2c4GhvAC7qhK6YUM3a14Lsa+bejarbQznjXy8HRgK/rm
   cE4HeS4kV5mve8knKMFc/EHIZEq8HoHQr+jWeZXtNqKUFEbwv9otDXSDK
   ipAPK560JCdN1EP+AuLuuVMS1Rb4DC3aLn4IHKpEQwPTyo/kgDSTMdNgF
   LSQYDDgSRwoGiRXDrkdyI0Lq+2JgTy5wkeQe0FbCmfcQYWNBqkdrnNsFV
   A==;
IronPort-SDR: hTjf6MVwyRDv3wPVMnEMMkhuHFYIcI9DAs+IzkqTfRrpqfEQIOnGgRN14HjTXOorRAfMTQT69t
 4wY+klGOZRh5upjOgBgHjjbi+Re8mvuv6StY+XU8UygzSUf6B3D/gnFoikMUGDdhZVko4k+PHw
 xnIVVTpVClNZJoe4WOksAp8ZqneFCl2M/pVz9Q9C4OZ+euovk8wbpw9VG6QnjPdkK2KE0AdlgZ
 tJzT6sK8ocie6vo/LLJXekeca8raboQltfl/DQfcGqg4wAhysT7gEwu/0p657K+TCKeMSPndg8
 rKQ=
X-IronPort-AV: E=Sophos;i="5.70,426,1574092800"; 
   d="scan'208";a="237549838"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 07:45:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TixomoT/8NamigLNZs+Ncd1CLbF2uOf9x2P47D2FsVAnUmuOiRFFv6mHaNVXb4B9jfP4YbmeY2kqP0gpeRNyOdE06l6NBVniy9NdDok9sv14+p9iacE+eaQw5xBEVJ+beDJdgoKe2g+mrWnVnXg+X5xvg0dhVrnqcEAtkaKL/9xDJngCMNP75P2dg+L1YhGUKHqZTUPyGAGhdN6vLhtTlkkpW0MlRZ23BOMI7NyXmn4LInp57S0Tbj13J4FlWUjAckHslYTiblfwCrPodXCWZFLSH5bktJi+Qj09xjbXxzpBOCVaddxCpzqBV4rRYBJi/u1kvza4an+mmbbwGLo/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ilX5NJepREOVyeEuzUeRWIbj2WJRUtRvV4rrK5U1jE=;
 b=fD0Fnl9GM8eLubvw8KoQ3aX0Fob4lfSQF9mCSK3/AIZC52jZ8z5Fk1Y5LRoi7ijCcFVgJkUVQbO45RQHavhDe39L5cCCZLfgJz4tiv2pX68CNZlBSfAIU5nTF8qrfAw4cC87zNvvWah3+nUZMdKcY8H4jEgedno88Ksr69PPC1hSINWPsnsriMXC9N46xC4WhWTVWeLnKQ8hzb+h5sZ4EgJPBR5odG7CDTuIT/lq+wmEBEJck8qubWVGFebSNR2y7VxY//qd4CLloaeLxGGZ2e1KQ+B3XTxohcDqqsSGlvHPDBe3a7mKbvyIVtmfincH3um6a9Um7Ojlw04sdlgS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ilX5NJepREOVyeEuzUeRWIbj2WJRUtRvV4rrK5U1jE=;
 b=luwNanHeW9SWWvn4mGv+sYAAQZAdglE6eIrIK+3yUEeCTyvtqtx+kMSv9qSoRKBJnk9eHCJNWAs+C5SwVXth5eQoC6lMrDizeeFlM8iOuZWMAY2Qm8FmpC1kilR/sVPO06XnR2I1HPNsveUDI6749M4CxYB2bupD6p3jUgKqxw4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5240.namprd04.prod.outlook.com (20.178.51.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Mon, 10 Feb 2020 23:45:14 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 23:45:13 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Christie <mchristi@redhat.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH 1/1] prctl.2: doc PR_SET/GET_IO_FLUSHER
Thread-Topic: [PATCH 1/1] prctl.2: doc PR_SET/GET_IO_FLUSHER
Thread-Index: AQHV4F+1fnID2nshokmlVTbOeXpjag==
Date:   Mon, 10 Feb 2020 23:45:13 +0000
Message-ID: <BYAPR04MB581696DC573970197C98FA0FE7190@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200210221557.8021-1-mchristi@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [2400:2411:43c0:6000:d4b4:4f80:d46e:1312]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc3928e2-b05d-4d02-6696-08d7ae83464f
x-ms-traffictypediagnostic: BYAPR04MB5240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB524016EFBFCC6A663E89DB38E7190@BYAPR04MB5240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(186003)(8936002)(478600001)(71200400001)(2906002)(52536014)(86362001)(316002)(7696005)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(33656002)(110136005)(5660300002)(55016002)(8676002)(81166006)(53546011)(81156014)(6506007)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5240;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mMNHv9VdCublHsnIx3d9CqhEPW7M1qwUfqPzRsmoXZqJo2ZFy4QcIeqEKWjAr4aLuXGGfB3wjJ/iGGltHZZ3VZpbsJcVX8B5pnRko0zGIljflpyHc3ecUcAx+mZGBWvBQZpz914usQvZf2uAvdq5mW8Hk8G9IhRCRrvTSoEj9whq0rD2TF6N7LTsSRFJ2Ql/ULETMBiENNx8i1mJwDkjg3NL1q6vVDk2NH8ADLVrRjaEblOUs7+7HfsZgLOyoqcmhRwbDLWDTKBsM8fx/Iu4idYhG49ChJTMOgAX3P84uw15KsPsenMzC6Gbls+9YWmiAVfeLuM71ooAyhwFSn5YUa3CinJgjdjHeIhERhC/pUJd/Mg93BOWTCZUZFNCRVyqPnG6bbzQbFPu1/GjotKvOZDH2QGb5y8njvXuQqnZdMstYKtvsGDai7SkP3GMV+dL
x-ms-exchange-antispam-messagedata: /KTtbpdLt761vPw/X/RH8/zWmXvplhjUM2ZwtzLzn5BL4HukCKZPcJ9GG1YyK71EYmV7COip3R9JfZu7Peu4qdDGYoeRzvshi8ufANemBnMjoUBUeXcCkHq8tOZvLklcd42aK100hZHdpJniJCq214MlurwAg/1Rk1NNZOmkcADZ4y9oqmiDfGg5SVmtG95Y2GQV1CbFD5jOKDsNnqH2ZA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3928e2-b05d-4d02-6696-08d7ae83464f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 23:45:13.8332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVBlQ7UqMkY88EFbL5TQIhh1Z+r4u44W4+/wrWNVcTAUgAzL8xCWAPpH7mhc+v1/+LEZnVmAA/mSYO9+kGYCOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5240
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2020/02/11 7:16, Mike Christie wrote:=0A=
> This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER=0A=
> prctl commands added to the linux kernel for 5.6 in commit:=0A=
> =0A=
> commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463=0A=
> Author: Mike Christie <mchristi@redhat.com>=0A=
> Date:   Mon Nov 11 18:19:00 2019 -0600=0A=
> =0A=
>     prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim=0A=
> =0A=
> Signed-off-by: Mike Christie <mchristi@redhat.com>=0A=
> ---=0A=
> =0A=
> V2:=0A=
> - My initial patch for this was very bad. This version is almost 100%=0A=
> taken word for word from Dave Chinner's review comments.=0A=
> =0A=
> =0A=
>  man2/prctl.2 | 25 +++++++++++++++++++++++++=0A=
>  1 file changed, 25 insertions(+)=0A=
> =0A=
> diff --git a/man2/prctl.2 b/man2/prctl.2=0A=
> index 720ec04e4..b481d186b 100644=0A=
> --- a/man2/prctl.2=0A=
> +++ b/man2/prctl.2=0A=
> @@ -1381,6 +1381,30 @@ system call on Tru64).=0A=
>  for information on versions and architectures.)=0A=
>  Return unaligned access control bits, in the location pointed to by=0A=
>  .IR "(unsigned int\ *) arg2" .=0A=
> +.TP=0A=
> +.B PR_SET_IO_FLUSHER (Since Linux 5.6)=0A=
> +An IO_FLUSHER is a user process that the kernel uses to issue IO=0A=
> +that cleans dirty page cache data and/or filesystem metadata. The=0A=
> +kernel may need to clean this memory when under memory pressure in=0A=
> +order to free it. This means there is potential for a memory reclaim=0A=
> +recursion deadlock if the user process attempts to allocate memory=0A=
> +and the kernel then blocks waiting for it to clean memory before it=0A=
> +can make reclaim progress.=0A=
> +=0A=
> +The kernel avoids these recursion problems internally via a special=0A=
> +process state that prevents recursive reclaim from issuing new IO.=0A=
> +If \fIarg2\fP is 1, the \fPPR_SET_IO_FLUSHER\fP control allows a userspa=
ce=0A=
> +process to set up this same process state and hence avoid the memory=0A=
> +reclaim recursion deadlocks in the same manner the kernel avoids them.=
=0A=
> +If \fIarg2\fP is 0, the process will clear the IO_FLUSHER state, and the=
=0A=
> +default behavior will be used.=0A=
> +=0A=
> +Examples of IO_FLUSHER applications are FUSE daemons, zoned disk=0A=
> +emulation daemons, etc."=0A=
=0A=
I would replace the "zoned disk emulation daemons" part with the more=0A=
general "SCSI device emulation daemons" since for tcmu-runner at least,=0A=
most emulation handlers can potentially trigger the reclaim deadlock (e.g.=
=0A=
file_handler).=0A=
=0A=
Apart from that, this looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
> +.TP=0A=
> +.B PR_GET_IO_FLUSHER (Since Linux 5.6)=0A=
> +Return as the function result 1 if the caller is in the IO_FLUSHER state=
 and=0A=
> +0 if not.=0A=
>  .SH RETURN VALUE=0A=
>  On success,=0A=
>  .BR PR_GET_DUMPABLE ,=0A=
> @@ -1395,6 +1419,7 @@ On success,=0A=
>  .BR PR_GET_SPECULATION_CTRL ,=0A=
>  .BR PR_MCE_KILL_GET ,=0A=
>  .BR PR_CAP_AMBIENT + PR_CAP_AMBIENT_IS_SET ,=0A=
> +.BR PR_GET_IO_FLUSHER ,=0A=
>  and (if it returns)=0A=
>  .BR PR_GET_SECCOMP=0A=
>  return the nonnegative values described above.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF7DB15CBB2
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 21:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBMUIr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 15:08:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40410 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbgBMUIr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 15:08:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DK3La0101687;
        Thu, 13 Feb 2020 20:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=pWVe89X3N6t9U4RXI3P+42mamXOoxCrycurwWPD2aMM=;
 b=l9Ocrs4YcQI1hjjBCYJ8I1C8+/q1G/3Z4pqV8irjM6xfdB6yrcDDn6WLxyxUtpqDzvLQ
 6vCQMRxnzAPR1SOl3Y+uPYnSS4m2hO0AqoHcG05bcuLhC9Um4AHJF0T7NCsnfCux/RHB
 j4zBfYta9UYhR8u6mml4pJqfvPnCNGFuhQ+5H0NwjLpYaaEs55dNJajBuAljFpeRWVMQ
 Fw5ph0VpSIj6oX9sc+Qt50MrgnL4XPr0XCsNJyXLvTaV7MKeaZAhc2FRSEiHkh9sy9NV
 h2VbfgpxNTBV3WR+PyA+GeQ0u1O3H1iXDK9tN64fNFJdajloJobRVnxUhdyVQiJGdttb YA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y2p3svtbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 20:08:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DK3Goe057042;
        Thu, 13 Feb 2020 20:08:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2y4k9jqgg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 20:08:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01DK8YcQ004757;
        Thu, 13 Feb 2020 20:08:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 12:08:33 -0800
Date:   Thu, 13 Feb 2020 12:08:32 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     linux-api@vger.kernel.org, david@fromorbit.com, mhocko@suse.com,
        masato.suzuki@wdc.com, damien.lemoal@wdc.com, bvanassche@acm.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Subject: Re: [PATCH 1/1] prctl.2: doc PR_SET/GET_IO_FLUSHER
Message-ID: <20200213200832.GU6874@magnolia>
References: <20200213182336.6663-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213182336.6663-1-mchristi@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=2 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=2 mlxlogscore=999 priorityscore=1501 clxscore=1011
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130140
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 13, 2020 at 12:23:36PM -0600, Mike Christie wrote:
> This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER
> prctl commands added to the linux kernel for 5.6 in commit:
> 
> commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Mon Nov 11 18:19:00 2019 -0600
> 
>     prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
> 
> V3:
> - Replace emulation device example.
> 
> V2:
> - My initial patch for this was very bad. This version is almost 100%
> taken word for word from Dave Chinner's review comments.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  man2/prctl.2 | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 720ec04e4..58d77bf2e 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1381,6 +1381,30 @@ system call on Tru64).
>  for information on versions and architectures.)
>  Return unaligned access control bits, in the location pointed to by
>  .IR "(unsigned int\ *) arg2" .
> +.TP
> +.B PR_SET_IO_FLUSHER (Since Linux 5.6)
> +An IO_FLUSHER is a user process that the kernel uses to issue IO
> +that cleans dirty page cache data and/or filesystem metadata. The
> +kernel may need to clean this memory when under memory pressure in
> +order to free it. This means there is potential for a memory reclaim
> +recursion deadlock if the user process attempts to allocate memory
> +and the kernel then blocks waiting for it to clean memory before it
> +can make reclaim progress.
> +
> +The kernel avoids these recursion problems internally via a special
> +process state that prevents recursive reclaim from issuing new IO.
> +If \fIarg2\fP is 1, the \fPPR_SET_IO_FLUSHER\fP control allows a userspace
> +process to set up this same process state and hence avoid the memory
> +reclaim recursion deadlocks in the same manner the kernel avoids them.
> +If \fIarg2\fP is 0, the process will clear the IO_FLUSHER state, and the
> +default behavior will be used.

I forget, does a program have to have special capabilities (e.g.
CAP_SYS_ADMIN) to be able to PR_SET_IO_FLUSHER?

--D

> +Examples of IO_FLUSHER applications are FUSE daemons, SCSI device
> +emulation daemons, etc."
> +.TP
> +.B PR_GET_IO_FLUSHER (Since Linux 5.6)
> +Return as the function result 1 if the caller is in the IO_FLUSHER state and
> +0 if not.
>  .SH RETURN VALUE
>  On success,
>  .BR PR_GET_DUMPABLE ,
> @@ -1395,6 +1419,7 @@ On success,
>  .BR PR_GET_SPECULATION_CTRL ,
>  .BR PR_MCE_KILL_GET ,
>  .BR PR_CAP_AMBIENT + PR_CAP_AMBIENT_IS_SET ,
> +.BR PR_GET_IO_FLUSHER ,
>  and (if it returns)
>  .BR PR_GET_SECCOMP
>  return the nonnegative values described above.
> -- 
> 2.21.0
> 

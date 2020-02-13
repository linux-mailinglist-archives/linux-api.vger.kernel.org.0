Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17A715CBCB
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 21:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBMUO4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 15:14:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37066 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727827AbgBMUO4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 15:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581624896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17dzDCWBFpOaXTWdDnMaW8gh3w7NZxo38Gq5oUZq7rM=;
        b=R2yY1P0tYCp0+7kpef29Dpc9weWEVZ7GfmmUlRnCUyMdG1kkXQriMhRZi5AOdl+uIInICn
        RixVDmsL3OaTYwRcCVxlDXgRlzvzcsZf8OK4IqxUZKBcUDNTc3fLb/+DVYoHjc+4kRtkKR
        P9VEl73LC8AFhV//urqc7/h3It4CdDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-TO8rT8yjPy2JsaFXDqxdAQ-1; Thu, 13 Feb 2020 15:14:53 -0500
X-MC-Unique: TO8rT8yjPy2JsaFXDqxdAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AE8A1005510;
        Thu, 13 Feb 2020 20:14:51 +0000 (UTC)
Received: from [10.10.125.76] (ovpn-125-76.rdu2.redhat.com [10.10.125.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BB755C1BB;
        Thu, 13 Feb 2020 20:14:49 +0000 (UTC)
Subject: Re: [PATCH 1/1] prctl.2: doc PR_SET/GET_IO_FLUSHER
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
References: <20200213182336.6663-1-mchristi@redhat.com>
 <20200213200832.GU6874@magnolia>
Cc:     linux-api@vger.kernel.org, david@fromorbit.com, mhocko@suse.com,
        masato.suzuki@wdc.com, damien.lemoal@wdc.com, bvanassche@acm.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E45AE39.2050509@redhat.com>
Date:   Thu, 13 Feb 2020 14:14:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20200213200832.GU6874@magnolia>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 02/13/2020 02:08 PM, Darrick J. Wong wrote:
> On Thu, Feb 13, 2020 at 12:23:36PM -0600, Mike Christie wrote:
>> This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER
>> prctl commands added to the linux kernel for 5.6 in commit:
>>
>> commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
>> Author: Mike Christie <mchristi@redhat.com>
>> Date:   Mon Nov 11 18:19:00 2019 -0600
>>
>>     prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim
>>
>> Signed-off-by: Mike Christie <mchristi@redhat.com>
>> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>
>> V3:
>> - Replace emulation device example.
>>
>> V2:
>> - My initial patch for this was very bad. This version is almost 100%
>> taken word for word from Dave Chinner's review comments.
>>
>> Signed-off-by: Mike Christie <mchristi@redhat.com>
>> ---
>>  man2/prctl.2 | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/man2/prctl.2 b/man2/prctl.2
>> index 720ec04e4..58d77bf2e 100644
>> --- a/man2/prctl.2
>> +++ b/man2/prctl.2
>> @@ -1381,6 +1381,30 @@ system call on Tru64).
>>  for information on versions and architectures.)
>>  Return unaligned access control bits, in the location pointed to by
>>  .IR "(unsigned int\ *) arg2" .
>> +.TP
>> +.B PR_SET_IO_FLUSHER (Since Linux 5.6)
>> +An IO_FLUSHER is a user process that the kernel uses to issue IO
>> +that cleans dirty page cache data and/or filesystem metadata. The
>> +kernel may need to clean this memory when under memory pressure in
>> +order to free it. This means there is potential for a memory reclaim
>> +recursion deadlock if the user process attempts to allocate memory
>> +and the kernel then blocks waiting for it to clean memory before it
>> +can make reclaim progress.
>> +
>> +The kernel avoids these recursion problems internally via a special
>> +process state that prevents recursive reclaim from issuing new IO.
>> +If \fIarg2\fP is 1, the \fPPR_SET_IO_FLUSHER\fP control allows a userspace
>> +process to set up this same process state and hence avoid the memory
>> +reclaim recursion deadlocks in the same manner the kernel avoids them.
>> +If \fIarg2\fP is 0, the process will clear the IO_FLUSHER state, and the
>> +default behavior will be used.
> 
> I forget, does a program have to have special capabilities (e.g.
> CAP_SYS_ADMIN) to be able to PR_SET_IO_FLUSHER?

Yes, CAP_SYS_RESOURCE. I will add that info.


> 
> --D
> 
>> +Examples of IO_FLUSHER applications are FUSE daemons, SCSI device
>> +emulation daemons, etc."
>> +.TP
>> +.B PR_GET_IO_FLUSHER (Since Linux 5.6)
>> +Return as the function result 1 if the caller is in the IO_FLUSHER state and
>> +0 if not.
>>  .SH RETURN VALUE
>>  On success,
>>  .BR PR_GET_DUMPABLE ,
>> @@ -1395,6 +1419,7 @@ On success,
>>  .BR PR_GET_SPECULATION_CTRL ,
>>  .BR PR_MCE_KILL_GET ,
>>  .BR PR_CAP_AMBIENT + PR_CAP_AMBIENT_IS_SET ,
>> +.BR PR_GET_IO_FLUSHER ,
>>  and (if it returns)
>>  .BR PR_GET_SECCOMP
>>  return the nonnegative values described above.
>> -- 
>> 2.21.0
>>
> 


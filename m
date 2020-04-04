Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5734519E7AD
	for <lists+linux-api@lfdr.de>; Sat,  4 Apr 2020 23:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDDVHi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 4 Apr 2020 17:07:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32525 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbgDDVHi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 4 Apr 2020 17:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586034457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4Sf7LyqqfhpsVkCDAaGxZwT9uYzAgzxhcfcN6LVPLo=;
        b=BcATlWlcECa+89mM+WHzNxHHXnJ7dtsvfUvQ4tnClzpBWumrnMgHXjxaCxbw2emGfd9RdM
        rzcDnL0BwxokNlplVWnYVyesY6adj5Q+2bfaerCvs6RFvVMM/GjWSz+Uejow3bk/iDjTl8
        eGaYto2m2vNEWIvcEfR3vWf0KAvFJSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-I67BNs4gNvmUkSjpoSMJZg-1; Sat, 04 Apr 2020 17:07:35 -0400
X-MC-Unique: I67BNs4gNvmUkSjpoSMJZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E5BA18A6ED2;
        Sat,  4 Apr 2020 21:07:33 +0000 (UTC)
Received: from [10.10.112.74] (ovpn-112-74.rdu2.redhat.com [10.10.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4298A94B40;
        Sat,  4 Apr 2020 21:07:32 +0000 (UTC)
Subject: Re: [PATCH] prctl.2: doc PR_SET/GET_IO_FLUSHER - V4
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-api@vger.kernel.org, david@fromorbit.com, mhocko@suse.com,
        masato.suzuki@wdc.com, damien.lemoal@wdc.com,
        darrick.wong@oracle.com, bvanassche@acm.org,
        linux-man@vger.kernel.org
References: <20200402020850.7218-1-mchristi@redhat.com>
 <111926f0-942c-66ea-4e43-9f90e7b43549@gmail.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E88F713.3050204@redhat.com>
Date:   Sat, 4 Apr 2020 16:07:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <111926f0-942c-66ea-4e43-9f90e7b43549@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 04/02/2020 07:16 AM, Michael Kerrisk (man-pages) wrote:
> Hello Mike,
> 
> On 4/2/20 4:08 AM, Mike Christie wrote:
>> This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER
>> prctl commands added to the linux kernel for 5.6 in commit:
>>
>> commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
>> Author: Mike Christie <mchristi@redhat.com>
>> Date:   Mon Nov 11 18:19:00 2019 -0600> 
>>     prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim
>>
>> Signed-off-by: Mike Christie <mchristi@redhat.com>
> 
> I've applied this patch, but I have some questions:

Hey,

Thanks for fixing up the patch for me.

> 
> (a) What happens to the IO_FLUSHER setting in the child of fork(2)?

The child will inherit the setting.

> (b) What happens to the IO_FLUSHER setting during an execve(2)?
>     (Is it preserved, reset, something else?)

It's preserved.


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7891DEFA6B
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 11:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfKEKGk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 05:06:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44088 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730718AbfKEKGk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 05:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572948399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxh+b8Zk81Uj86ZXD24/0mn4MPIM+6Xqq2DkuEn+yZE=;
        b=inKFBza40ZIJjZwoffaaWYx7tlBvVAqAgTuONuJI4RbTNSua8Cu5vAUjiJyQ8v+QceCddU
        G5vynCVMz9qOeexWDvqXBKfSqo6bJeUlI72O0xHoAaHeULFPyiiTyTiqGD78si46ihIMd2
        5YFRQ4m9BRHbeWFg+GYwgptwPi1UGyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-fpr2-B8NOsapmixi-wTVVQ-1; Tue, 05 Nov 2019 05:06:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13304107ACC2;
        Tue,  5 Nov 2019 10:06:34 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-117-86.ams2.redhat.com [10.36.117.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF7F45D713;
        Tue,  5 Nov 2019 10:06:27 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Shawn Landden <shawn@git.icu>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking ABIs at the same time.
References: <20191104002909.25783-1-shawn@git.icu>
        <87woceslfs.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
Date:   Tue, 05 Nov 2019 11:06:25 +0100
In-Reply-To: <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 5 Nov 2019 10:59:24 +0100 (CET)")
Message-ID: <87sgn2skm6.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: fpr2-B8NOsapmixi-wTVVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Thomas Gleixner:

> On Tue, 5 Nov 2019, Florian Weimer wrote:
>> * Shawn Landden:
>> > If this new ABI is used, then bit 1 of the *next pointer of the
>> > user-space robust_list indicates that the futex_offset2 value should
>> > be used in place of the existing futex_offset.
>>=20
>> The futex interface currently has some races which can only be fixed by
>> API changes.  I'm concerned that we sacrifice the last bit for some
>> rather obscure feature.  What if we need that bit for fixing the
>> correctness issues?
>
> That current approach is going nowhere and if we change the ABI ever then
> this needs to happen with all *libc folks involved and agreeing.
>
> Out of curiosity, what's the race issue vs. robust list which you are
> trying to solve?

Sadly I'm not trying to solve them.  Here's one of the issues:

  <https://sourceware.org/bugzilla/show_bug.cgi?id=3D14485>

I think there are others, but I can't find a reference to them.  If
anyone wants to work on this, I can dig out the details and ask some
folks who have looked at this in the past.

Thanks,
Florian


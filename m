Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F74EFFE0
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389563AbfKEOd4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 09:33:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42324 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389696AbfKEOd4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 09:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572964435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kf4mHA+y3oJq+QHstu4rI1MJktm5ZOdROwo+HsHEzdY=;
        b=Bl8uPG5IIVtVhYPTFly7MqsR2OIw1WAJ3kg0if6f4JPQJFoIkoPxg5lAm8ygLW/R3V5Ifr
        IJZgsL0FGcGiEfwqLsi7coXx2clgx2mb8H4f4y/2XPCuCnwCbMoMoYCgVTCUDqpI6FjSFi
        lZcS0YPLfEsit1T+w4n5Ui+w0U9WOb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-qAiX2K9vNrGbjATq5FX2UA-1; Tue, 05 Nov 2019 09:33:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 138311800D4A;
        Tue,  5 Nov 2019 14:33:48 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-230.str.redhat.com [10.33.192.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23AAF600C6;
        Tue,  5 Nov 2019 14:33:40 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Carlos O'Donell <carlos@redhat.com>, Shawn Landden <shawn@git.icu>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
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
        <87sgn2skm6.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1911051253430.17054@nanos.tec.linutronix.de>
        <f11d82f1-1e81-e344-3ad2-76e4cb488a3d@redhat.com>
        <alpine.DEB.2.21.1911051520090.17054@nanos.tec.linutronix.de>
Date:   Tue, 05 Nov 2019 15:33:38 +0100
In-Reply-To: <alpine.DEB.2.21.1911051520090.17054@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 5 Nov 2019 15:27:54 +0100 (CET)")
Message-ID: <87k18eqtod.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qAiX2K9vNrGbjATq5FX2UA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Thomas Gleixner:

> On Tue, 5 Nov 2019, Carlos O'Donell wrote:
>> On 11/5/19 6:56 AM, Thomas Gleixner wrote:
>> The other issue is this:
>>=20
>> "Robust mutexes do not take ROBUST_LIST_LIMIT into account"
>> https://sourceware.org/bugzilla/show_bug.cgi?id=3D19089
>
>   "The kernel limits the length of the robust mutex list to 2048 entries.
>    This constant does not seem to be exported to user space."
>
> FWIW, the constant is defined in the UAPI futex header.
>
> The main concern here is not the actual number of futexes held by a task.
>
> The real issue is that the robust list could be circular by incident or
> malice and there is no way for the kernel to figure that out. That would
> prevent the task from exiting and make it iterate over the list until
> doomsday, i.e. a nice unpriviledged DoS.
>
> So I fear the kernel cannot really help with this one.

I'm actually fine with treating ROBUST_LIST_LIMIT as an ABI constant.
It's just not clear to me if the constant has this status today.  I
suspect it was just split from the implementation headers at one point.

Thanks,
Florian


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4DEF17E3
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2019 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfKFOEm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Nov 2019 09:04:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43188 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727128AbfKFOEm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 Nov 2019 09:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573049081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjDw7VtURttV92AniQsvr1aCutSqy+spKGbff6QZDRU=;
        b=KmC6l7I7mRzFWAOGXISq6O+F+CeMtzuxn8ZhP2rBrSRBWqlL8ikXIIjiMbwn9MdxBxofh5
        8Sj97ssa5ROG/Ug3U1OrQzeNHMGMyhddItAz5DTFckt6WM7h4DqkE3diW8JRRJ/Dqm9O0+
        smD+gANR8EwnkOINKB0yKcWz30HPb6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-SlrdrPz0OqCEPyD-rxFU8w-1; Wed, 06 Nov 2019 09:04:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A1891005500;
        Wed,  6 Nov 2019 14:04:35 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-224.ams2.redhat.com [10.36.116.224])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F539608B8;
        Wed,  6 Nov 2019 14:04:19 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Zack Weinberg <zackw@panix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Shawn Landden <shawn@git.icu>,
        GNU C Library <libc-alpha@sourceware.org>,
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
        <87sgn2skm6.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1911051253430.17054@nanos.tec.linutronix.de>
        <f11d82f1-1e81-e344-3ad2-76e4cb488a3d@redhat.com>
        <alpine.DEB.2.21.1911051520090.17054@nanos.tec.linutronix.de>
        <CAKCAbMjYBpTjwyMJkkENps09o4KFoQAb_KOKp4g0BtWUXjYAzQ@mail.gmail.com>
Date:   Wed, 06 Nov 2019 15:04:17 +0100
In-Reply-To: <CAKCAbMjYBpTjwyMJkkENps09o4KFoQAb_KOKp4g0BtWUXjYAzQ@mail.gmail.com>
        (Zack Weinberg's message of "Wed, 6 Nov 2019 09:00:51 -0500")
Message-ID: <87a799nlsu.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: SlrdrPz0OqCEPyD-rxFU8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Zack Weinberg:

> On Tue, Nov 5, 2019 at 9:28 AM Thomas Gleixner <tglx@linutronix.de> wrote=
:
>>
>> The real issue is that the robust list could be circular by incident or
>> malice and there is no way for the kernel to figure that out. That would
>> prevent the task from exiting and make it iterate over the list until
>> doomsday, i.e. a nice unpriviledged DoS.
>
> Why can't the kernel use the standard tortoise-and-hare algorithm for
> detecting circular linked lists here?

It's not guaranteed to terminate if the list is in shared memory.

Thanks,
Florian


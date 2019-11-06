Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A6DF140A
	for <lists+linux-api@lfdr.de>; Wed,  6 Nov 2019 11:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfKFKfY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Nov 2019 05:35:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32185 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727239AbfKFKfU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 Nov 2019 05:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573036519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVnePUZZwzprHYOXaNvUDvhLwt5XtmaSUL7fEAR5TpE=;
        b=N0yl8oJahNwq4gYm6PntQtECIk4AsmT+j7WIU6cwp+ldhU7Js3Oj7T5qmPFsvRGVfdMF2b
        QZdksEXeWDJX9VrKfq3hVXZ1l0Rcyy8TZPu54aHLM/sSwJ7XOuDe8GaVofBe+CEcgje6n3
        7VcexgrT8EGqaA91GZdPGCRH7yAvAP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-3WoS9rMNPKWwRDz_ANwNDw-1; Wed, 06 Nov 2019 05:35:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0967F1800D53;
        Wed,  6 Nov 2019 10:35:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 50EE45D9CD;
        Wed,  6 Nov 2019 10:35:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  6 Nov 2019 11:35:13 +0100 (CET)
Date:   Wed, 6 Nov 2019 11:35:10 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Florian Weimer <fweimer@redhat.com>, Shawn Landden <shawn@git.icu>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: handle_exit_race && PF_EXITING
Message-ID: <20191106103509.GB12575@redhat.com>
References: <20191104002909.25783-1-shawn@git.icu>
 <87woceslfs.fsf@oldenburg2.str.redhat.com>
 <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
 <20191105152728.GA5666@redhat.com>
 <alpine.DEB.2.21.1911051800070.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051851380.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051920420.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051959260.1869@nanos.tec.linutronix.de>
 <20191106085529.GA12575@redhat.com>
 <alpine.DEB.2.21.1911061028020.1869@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911061028020.1869@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3WoS9rMNPKWwRDz_ANwNDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/06, Thomas Gleixner wrote:
>
> > @@ -716,11 +716,13 @@ void exit_pi_state_list(struct task_struct *curr)
> >
> >  =09if (!futex_cmpxchg_enabled)
> >  =09=09return;
> > +
> >  =09/*
> > -=09 * We are a ZOMBIE and nobody can enqueue itself on
> > -=09 * pi_state_list anymore, but we have to be careful
> > -=09 * versus waiters unqueueing themselves:
> > +=09 * attach_to_pi_owner() can no longer add the new entry. But
> > +=09 * we have to be careful versus waiters unqueueing themselves.
> >  =09 */
> > +=09curr->flags |=3D PF_EXITPIDONE;
>
> This obviously would need a barrier or would have to be moved inside of t=
he
> pi_lock region.

probably yes,

> > +=09if (unlikely(p->flags & PF_EXITPIDONE)) {
> > +=09=09/* exit_pi_state_list() was already called */
> >  =09=09raw_spin_unlock_irq(&p->pi_lock);
> >  =09=09put_task_struct(p);
> > -=09=09return ret;
> > +=09=09return -ESRCH;
>
> But, this is incorrect because we'd return -ESRCH to user space while the
> futex value still has the TID of the exiting task set which will
> subsequently cleanout the futex and set the owner died bit.

Heh. Of course this is not correct. As I said, this patch should be adapted
to the current code. See below.

> See da791a667536 ("futex: Cure exit race") for example.

Thomas, I simply can't resist ;)

I reported this race when I sent this patch in 2015,

https://lore.kernel.org/lkml/20150205181014.GA20244@redhat.com/

but somehow that discussion died with no result.

> Guess why that code has more corner case handling than actual
> functionality. :)

I know why. To confuse me!

Oleg.


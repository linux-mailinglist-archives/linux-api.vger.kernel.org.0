Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085F6F015D
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 16:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbfKEP1m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 10:27:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389722AbfKEP1m (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 10:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572967660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvUBd68QYOf4zjMI6uQSjQ5CMU0M3270wf5ewDe4CGw=;
        b=dCgHDm4IOxe7/9fsweCZ52menWoXSlKP02PxcXvwAdEo84VTm/CJG3hMuUZS9RWmpe2nRH
        sgrce0oQdm5QBa5CKepfRNpexUR3GITvw6khgLCVuM9Euxtdfz64RnjMg2IrOdH71X3BTz
        G7wYMKJnfm0hYWKcQQsJw8XnDXAwVVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-dCJ-gZydN4yeQdyHHg-p0Q-1; Tue, 05 Nov 2019 10:27:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 124781005502;
        Tue,  5 Nov 2019 15:27:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B6543C1D;
        Tue,  5 Nov 2019 15:27:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  5 Nov 2019 16:27:31 +0100 (CET)
Date:   Tue, 5 Nov 2019 16:27:28 +0100
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
Subject: handle_exit_race && PF_EXITING
Message-ID: <20191105152728.GA5666@redhat.com>
References: <20191104002909.25783-1-shawn@git.icu>
 <87woceslfs.fsf@oldenburg2.str.redhat.com>
 <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dCJ-gZydN4yeQdyHHg-p0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/05, Thomas Gleixner wrote:
>
> Out of curiosity, what's the race issue vs. robust list which you are
> trying to solve?

Off-topic, but this reminds me...

=09#include <sched.h>
=09#include <assert.h>
=09#include <unistd.h>
=09#include <syscall.h>

=09#define FUTEX_LOCK_PI=09=096

=09int main(void)
=09{
=09=09struct sched_param sp =3D {};

=09=09sp.sched_priority =3D 2;
=09=09assert(sched_setscheduler(0, SCHED_FIFO, &sp) =3D=3D 0);

=09=09int lock =3D vfork();
=09=09if (!lock) {
=09=09=09sp.sched_priority =3D 1;
=09=09=09assert(sched_setscheduler(0, SCHED_FIFO, &sp) =3D=3D 0);
=09=09=09_exit(0);
=09=09}

=09=09syscall(__NR_futex, &lock, FUTEX_LOCK_PI, 0,0,0);
=09=09return 0;
=09}

this creates the unkillable RT process spinning in futex_lock_pi() on
a single CPU machine (or you can use taskset).

Probably the patch below makes sense anyway, but of course it doesn't
solve the real problem: futex_lock_pi() should not spin in this case.

It seems to me I even sent the fix a long ago, but I can't recall what
exactly it did. Probably the PF_EXITING check in attach_to_pi_owner()
must simply die, I'll try to recall...

Oleg.

--- x/kernel/futex.c
+++ x/kernel/futex.c
@@ -2842,10 +2842,12 @@ static int futex_lock_pi(u32 __user *uaddr, unsigne=
d int flags,
 =09=09=09 *   exit to complete.
 =09=09=09 * - The user space value changed.
 =09=09=09 */
-=09=09=09queue_unlock(hb);
-=09=09=09put_futex_key(&q.key);
-=09=09=09cond_resched();
-=09=09=09goto retry;
+=09=09=09if (!fatal_signal_pending(current)) {
+=09=09=09=09queue_unlock(hb);
+=09=09=09=09put_futex_key(&q.key);
+=09=09=09=09cond_resched();
+=09=09=09=09goto retry;
+=09=09=09}
 =09=09default:
 =09=09=09goto out_unlock_put_key;
 =09=09}


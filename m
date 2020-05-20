Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D081DAFCD
	for <lists+linux-api@lfdr.de>; Wed, 20 May 2020 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgETKOu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 May 2020 06:14:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgETKOu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 May 2020 06:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589969689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bLHtz3BV/L39/FW/oh2sYThZNFwq67XjK/qDci+qxM=;
        b=WuO/L4wO4LlyvpyuTe3c+K8SmtdWkaUTDX5fwtnrX9YNy+8LeEwuM866A+00y9/2I2qyNF
        g3hkFbzC2sSGd8GuNrAjwFaun8Dh1wQe2Onji8VeE5C+Iizyh2PLzTJOHHti1dgNVOi7Dt
        f6MO/6wudMvGyB3eG5wmxX5hKlB5zxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-jycBi55nM4SRI02W8w7-FA-1; Wed, 20 May 2020 06:14:44 -0400
X-MC-Unique: jycBi55nM4SRI02W8w7-FA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C32100CCC4;
        Wed, 20 May 2020 10:14:42 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-191.ams2.redhat.com [10.36.113.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C419707B8;
        Wed, 20 May 2020 10:14:39 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-api@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH glibc 2/3] glibc: sched_getcpu(): use rseq cpu_id TLS on Linux (v7)
References: <20200501021439.2456-1-mathieu.desnoyers@efficios.com>
        <20200501021439.2456-3-mathieu.desnoyers@efficios.com>
Date:   Wed, 20 May 2020 12:14:38 +0200
In-Reply-To: <20200501021439.2456-3-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers via Libc-alpha's message of "Thu, 30 Apr 2020 22:14:38
        -0400")
Message-ID: <87imgqdib5.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers via Libc-alpha:

> diff --git a/sysdeps/unix/sysv/linux/sched_getcpu.c b/sysdeps/unix/sysv/l=
inux/sched_getcpu.c
> index c019cfb3cf..2269c4f2bd 100644
> --- a/sysdeps/unix/sysv/linux/sched_getcpu.c
> +++ b/sysdeps/unix/sysv/linux/sched_getcpu.c
> @@ -18,10 +18,15 @@
>  #include <errno.h>
>  #include <sched.h>
>  #include <sysdep.h>
> +#include <atomic.h>
>  #include <sysdep-vdso.h>
>=20=20
> -int
> -sched_getcpu (void)
> +#ifdef HAVE_GETCPU_VSYSCALL
> +# define HAVE_VSYSCALL
> +#endif

I think the #ifdef is a result of an incorrect merge of commit
d0def09ff6bbf1537beec305fdfe96a21174fb31 ("linux: Fix vDSO macros build
with time64 interfaces") and it should be removed.

The commit subject should probably say =E2=80=9CLinux: Use rseq in sched_ge=
tcpu
if available=E2=80=9D.

Thanks,
Florian


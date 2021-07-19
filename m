Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC953CEFB9
	for <lists+linux-api@lfdr.de>; Tue, 20 Jul 2021 01:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbhGSWi3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Jul 2021 18:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385722AbhGSTH6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Jul 2021 15:07:58 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B547C061797
        for <linux-api@vger.kernel.org>; Mon, 19 Jul 2021 12:39:08 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id r9so7243918ual.7
        for <linux-api@vger.kernel.org>; Mon, 19 Jul 2021 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pU0r9hs1kSSmt7CkjgwyTiy4kbef4H0m4sD9VOE0lo=;
        b=Zw6wW8nxfTH3oPBuzjCMM6QBD3EdkiqPi2mbT24EnTuEmWFHKbFCrGK7tDiAtZ5PhG
         QZ9zw6G+u4F3IvKJ5PEIcpHHwrBklvy3fkXpOJpVRyJdq2wHM+5AFv+caKizuckLdBj1
         c4FojA6liKva3VOa3kT6SgTn0TLi2aiqBJWyNtCZMPKdRP4qj6nAd6mcMnE88OXcS10L
         Ly1s6JfOznAi0b9FrqGHP0/DkFHjWqEKctXwWiENZbEL8w1PPfkgA2U65oSJO5m/C13x
         ZDwdeaS0XP5NLEfKVlanbGdfAj6HPy4n2p5asPtynoLdphyqW3V3PV+hJ1RJVAiYVZF6
         k6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pU0r9hs1kSSmt7CkjgwyTiy4kbef4H0m4sD9VOE0lo=;
        b=FC3nSdB+Wvm49t+tRUV9284pz74yn6t0fG3scq4L6s+Wj2B++I4L8h7LcRamXVi1Po
         tRNQmzQHFQlDW/r16T9VlgwBdvWi/aQrf0i4qyl1TilSK0RvzqPh5bNp8xxLZsJJ7Lql
         ogfqxByy4zkrFlB2fNp1WUKxbB+QGVGrfEHz0Lc+qbAiJlai5NNf8oHgTI41kpmz/OTx
         H8cBBiI//l2aVn+PsueCfY17tEVeZjJvW9fdSu/dOXBubtKlwaRRmTnshA1rxpqpR6mI
         uWX33ucqIXI106cdZprb+Bbeb8aBV3ZG1Q5yD+wfpK2U3YuJ6jeUhuAm54wxjtiLEtgP
         JR6g==
X-Gm-Message-State: AOAM530TBFzAltNeeWqbe4B7ePSfi1+We4WQQSGMmtQtFZ+OLnDVLwSU
        7A1z2BY5mm4dCsIidaBG9QnAuvSBC71J3pq9KiJrzg==
X-Google-Smtp-Source: ABdhPJySfYjYdDPgPbT9XBnhI5qPVRSnT0qpEyR/JfRmjjij3OXAoS/C+layO1q6+PDoVPWSQtW0bzSPO6CEQdBgCYo=
X-Received: by 2002:ab0:6797:: with SMTP id v23mr27731456uar.71.1626723980418;
 Mon, 19 Jul 2021 12:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210716184719.269033-5-posk@google.com> <2c971806-b8f6-50b9-491f-e1ede4a33579@uwaterloo.ca>
 <CAPNVh5cmhFEWr4bmODkDDFhV=mHLcO0DZJ432GEL=OitzPP80g@mail.gmail.com> <c8ea4892-51e5-0dc2-86c6-b705e8a23cde@uwaterloo.ca>
In-Reply-To: <c8ea4892-51e5-0dc2-86c6-b705e8a23cde@uwaterloo.ca>
From:   Peter Oskolkov <posk@posk.io>
Date:   Mon, 19 Jul 2021 12:46:09 -0700
Message-ID: <CAFTs51XW0H1UJKv0t2tq+5VLfgPMtZmDcxQVUQ5HkgDe38jHpw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4 v0.3] sched/umcg: RFC: implement UMCG syscalls
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     Peter Oskolkov <posk@google.com>, Andrei Vagin <avagin@google.com>,
        Ben Segall <bsegall@google.com>, Jann Horn <jannh@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-api@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Buhr <pabuhr@uwaterloo.ca>
Content-Type: multipart/mixed; boundary="00000000000000512205c77f31f3"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

--00000000000000512205c77f31f3
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 19, 2021 at 11:13 AM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
>  > Latency/efficiency: on worker wakeup an idle server can be picked from
>  > the list and context-switched into synchronously, on the same CPU.
>  > Using FDs and select/poll/epoll will add extra layers of abstractions;
>  > synchronous context-switches (not yet fully implemented in UMCG) will
>  > most likely be impossible. This patchset seems much more efficient and
>  > lightweight than whatever can be built on top of FDs.
>
> I can believe that.
>
> Are you planning to support separate scheduling instances within a
> single user
> space? That is having multiple sets of server threads and workers can
> only run
> within a specific set.

Yes, this is naturally supported in the current patchset on the kernel
side, and is supported in libumcg (to be posted, later when the kernel
side is settled); internally at Google, some applications use
different "groups" of workers/servers per NUMA node.

>
> I believe the problem with the idle_servers_ptr as specified is that it
> is not
> possible to reclaim used nodes safely. I don't see any indication of which
> nodes the kernel can concurrently access and on which some memory
> reclamation
> scheme could be based.

Please see the attached atomic_stack.h file - I use it in my tests,
things seem to be working. Specifically, atomic_stack_gc does the
cleanup. For the kernel side of things, see the third patch in this
patchset.

>
> What is the benefit of having users maintain themselves a list of idle
> servers
> rather than each servers marking themselves as 'out of work' and having the
> kernel maintain the list?

To keep the kernel side light and simple. To also protect the kernel
from spinning if userspace misbehaves. Basically, the overall approach
is to delegate most of the work to the userspace, and keep the bare
minimum in the kernel.

--00000000000000512205c77f31f3
Content-Type: text/x-chdr; charset="US-ASCII"; name="atomic_stack.h"
Content-Disposition: attachment; filename="atomic_stack.h"
Content-Transfer-Encoding: base64
Content-ID: <f_krb1avrq0>
X-Attachment-Id: f_krb1avrq0

LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8KCiNpZm5kZWYgX19BVE9NSUNf
U1RBQ0tfSAojZGVmaW5lIF9fQVRPTUlDX1NUQUNLX0gKCiNpbmNsdWRlIDxhc3NlcnQuaD4KI2lu
Y2x1ZGUgPHN0ZGF0b21pYy5oPgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3RkZGVm
Lmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KCiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3Rk
bGliLmg+CgovKgogKiBBdG9taWMgU3RhY2s6IGEgc2lnbGUtbGlua2VkIHN0YWNrIHRoYXQgYWxs
b3dzIGZ1bGx5IGNvbmN1cnJlbnQKICogcHVzaC9wb3Agb3BlcmF0aW9ucy4KICoKICogVGhlIHN0
YWNrIGlzIHNpbXBsZTogaGVhZC0+bm9kZS0+bm9kZS0+TlVMTC4KICoKICoKICogU2FtcGxlIHVz
YWdlOgogKgogKglzdHJ1Y3QgbXlfc3RhY2tfbm9kZSB7CiAqCQl0eXBlMSB2YWwxOwogKgkJdHlw
ZTIgdmFsMjsKICoJCXVpbnQ2NF90IG5leHQ7CiAqCX0gX19hdHRyaWJ1dGVfXygoYWxpZ25lZCg4
KSkpOwogKgogKgl1aW50NjRfdCBoZWFkID0gMFVMOwogKglzdHJ1Y3QgbXlfc3RhY2tfbm9kZSAq
bm9kZTsKICoKICoJbm9kZSA9IG1hbGxvYyhzaXplb2Yoc3RydWN0IG15X3N0YWNrX25vZGUpKTsK
ICoJbm9kZS0+dmFsMSA9IHh4eDsKICoJbm9kZS0+dmFsMiA9IHl5eTsKICoJYXRvbWljX3N0YWNr
X3B1c2goJmhlYWQsICZub2RlLT5uZXh0KTsKICoKICoJYXNzZXJ0KG5vZGUgPT0gY29udGFpbmVy
X29mKGF0b21pY19zdGFja19wb3AoJmhlYWQpLAogKgkJCQkJc3RydWN0IG15X3N0YWNrX25vZGUs
IG5leHQpKTsKICovCgovKioKICogYXRvbWljX3N0YWNrX2lzX2VtcHR5IC0gY2hlY2sgaWYgdGhl
IHN0YWNrIGlzIGVtcHR5CiAqIEBoZWFkIC0gYSBwb2ludGVyIHRvIHRoZSBoZWFkIG9mIHRoZSBz
dGFjay4KICovCnN0YXRpYyBpbmxpbmUgYm9vbCBhdG9taWNfc3RhY2tfaXNfZW1wdHkodWludDY0
X3QgKmhlYWQpCnsKCXVpbnQ2NF90IGN1cnIgPSBhdG9taWNfbG9hZF9leHBsaWNpdChoZWFkLCBt
ZW1vcnlfb3JkZXJfYWNxdWlyZSk7CgoJZG8gewoJCXVpbnQ2NF90IG5leHQ7CgoJCWlmICghY3Vy
cikKCQkJcmV0dXJuIHRydWU7CgoJCWFzc2VydCghKGN1cnIgJiAxVUwpKTsKCQluZXh0ID0gYXRv
bWljX2xvYWRfZXhwbGljaXQoKHVpbnQ2NF90ICopY3VyciwgbWVtb3J5X29yZGVyX2FjcXVpcmUp
OwoJCWlmICghKG5leHQgJiAxVUwpKQoJCQlyZXR1cm4gZmFsc2U7ICAvKiBmb3VuZCBhIG5vbi1k
ZWxldGVkIG5vZGUgKi8KCgkJY3VyciA9IG5leHQgJiB+MVVMOwoJfSB3aGlsZSAodHJ1ZSk7Cn0K
Ci8qKgogKiBhdG9taWNfc3RhY2tfcHVzaCAtIHB1c2ggYSBub2RlIG9udG8gdGhlIHN0YWNrCiAq
IEBoZWFkIC0gYSBwb2ludGVyIHRvIHRoZSBoZWFkIG9mIHRoZSBzdGFjazsKICogQG5vZGUgLSBh
IHBvaW50ZXIgdG8gdGhlIG5vZGUgdG8gcHVzaC4KICovCnN0YXRpYyBpbmxpbmUgdm9pZCBhdG9t
aWNfc3RhY2tfcHVzaCh1aW50NjRfdCAqaGVhZCwgdWludDY0X3QgKm5vZGUpCnsKCXdoaWxlICh0
cnVlKSB7CgkJdWludDY0X3QgZmlyc3QgPSBhdG9taWNfbG9hZF9leHBsaWNpdChoZWFkLAoJCQkJ
bWVtb3J5X29yZGVyX2FjcXVpcmUpOwoKCQlhdG9taWNfc3RvcmVfZXhwbGljaXQobm9kZSwgZmly
c3QsIG1lbW9yeV9vcmRlcl9yZWxlYXNlKTsKCgkJaWYgKGF0b21pY19jb21wYXJlX2V4Y2hhbmdl
X3dlYWtfZXhwbGljaXQoaGVhZCwgJmZpcnN0LAoJCQkJCSh1aW50NjRfdClub2RlLAoJCQkJCW1l
bW9yeV9vcmRlcl9hY3FfcmVsLAoJCQkJCW1lbW9yeV9vcmRlcl9yZWxheGVkKSkKCQkJcmV0dXJu
OwoJfQp9CgovKioKICogYXRvbWljX3N0YWNrX3BvcCAtIHBvcCBhIG5vZGUgZnJvbSB0aGUgc3Rh
Y2sKICogQGhlYWQgLSBhIHBvaW50ZXIgdG8gdGhlIGhlYWQgb2YgdGhlIHN0YWNrLgogKgogKiBS
ZXR1cm5zIGEgcG9pbnRlciB0byB0aGUgcG9wcGVkIG5vZGUgKHRvIGJlIHVzZWQgaW4gY29udGFp
bmVyX29mKSwgb3IgTlVMTAogKiBpZiB0aGUgc3RhY2sgaXMgZW1wdHkuCiAqLwpzdGF0aWMgaW5s
aW5lIHVpbnQ2NF90KiBhdG9taWNfc3RhY2tfcG9wKHVpbnQ2NF90ICpoZWFkKQp7Cgl1aW50NjRf
dCAqY3VyciA9ICh1aW50NjRfdCAqKWF0b21pY19sb2FkX2V4cGxpY2l0KGhlYWQsCgkJCQkJbWVt
b3J5X29yZGVyX2FjcXVpcmUpOwoKCWRvIHsKCQl1aW50NjRfdCBuZXh0OwoKCQlpZiAoIWN1cnIp
CgkJCXJldHVybiBOVUxMOwoKCQlhc3NlcnQoISgodWludDY0X3QpY3VyciAmIDFVTCkpOwoJCW5l
eHQgPSBhdG9taWNfbG9hZF9leHBsaWNpdChjdXJyLCBtZW1vcnlfb3JkZXJfYWNxdWlyZSk7CgoJ
CWlmIChuZXh0ICYgMVVMKSB7IC8qIGN1cnIgaXMgZGVsZXRlZCAqLwoJCQljdXJyID0gKHVpbnQ2
NF90ICopKG5leHQgJiB+MVVMKTsKCQkJY29udGludWU7CgkJfQoKCQlpZiAoYXRvbWljX2NvbXBh
cmVfZXhjaGFuZ2Vfc3Ryb25nX2V4cGxpY2l0KGN1cnIsCgkJCQkmbmV4dCwgbmV4dCB8IDFVTCwK
CQkJCW1lbW9yeV9vcmRlcl9yZWxlYXNlLCBtZW1vcnlfb3JkZXJfcmVsYXhlZCkpCgkJCXJldHVy
biBjdXJyOwoKCQljdXJyID0gKHVpbnQ2NF90ICopKG5leHQgJiB+MVVMKTsKCX0gd2hpbGUgKHRy
dWUpOwp9CgpzdGF0aWMgaW5saW5lIGJvb2wgYXRvbWljX3N0YWNrX3JlbW92ZSh1aW50NjRfdCAq
aGVhZCwgdWludDY0X3QgKm5vZGUpCnsKCXVpbnQ2NF90ICpjdXJyID0gKHVpbnQ2NF90ICopYXRv
bWljX2xvYWRfZXhwbGljaXQoaGVhZCwKCQkJCQltZW1vcnlfb3JkZXJfYWNxdWlyZSk7CgoJZG8g
ewoJCXVpbnQ2NF90IG5leHQ7CgoJCWlmICghY3VycikKCQkJcmV0dXJuIGZhbHNlOwoKCQluZXh0
ID0gYXRvbWljX2xvYWRfZXhwbGljaXQoY3VyciwgbWVtb3J5X29yZGVyX2FjcXVpcmUpOwoKCQlp
ZiAobmV4dCAmIDFVTCkgeyAvKiBjdXJyIGlzIGRlbGV0ZWQgKi8KCQkJaWYgKGN1cnIgPT0gbm9k
ZSkKCQkJCXJldHVybiBmYWxzZTsKCQkJY3VyciA9ICh1aW50NjRfdCAqKShuZXh0ICYgfjFVTCk7
CgkJCWNvbnRpbnVlOwoJCX0KCgkJaWYgKGN1cnIgPT0gbm9kZSkKCQkgICAgICAgcmV0dXJuIGF0
b21pY19jb21wYXJlX2V4Y2hhbmdlX3N0cm9uZ19leHBsaWNpdCgKCQkJCQljdXJyLCAmbmV4dCwg
bmV4dCB8IDFVTCwKCQkJCQltZW1vcnlfb3JkZXJfcmVsZWFzZSwKCQkJCQltZW1vcnlfb3JkZXJf
cmVsYXhlZCk7CgoJCWN1cnIgPSAodWludDY0X3QgKikobmV4dCAmIH4xVUwpOwoJfSB3aGlsZSAo
dHJ1ZSk7Cn0KCi8qKgogKiBhdG9taWNfc3RhY2tfcG9wX2FsbCAtIHBvcCBhbGwgbm9kZXMgZnJv
bSB0aGUgc3RhY2sKICogQGhlYWQgLSBhIHBvaW50ZXIgdG8gdGhlIGhlYWQgb2YgdGhlIHN0YWNr
LgogKgogKiBSZXR1cm5zIGEgcG9pbnRlciB0byB0aGUgZmlyc3Qgbm9kZSAodG8gYmUgdXNlZCBp
biBjb250YWluZXJfb2YpLCBvciBOVUxMCiAqIGlmIHRoZSBzdGFjayBpcyBlbXB0eS4KICovCnN0
YXRpYyBpbmxpbmUgdWludDY0X3QqIGF0b21pY19zdGFja19wb3BfYWxsKHVpbnQ2NF90ICpoZWFk
KQp7Cgl3aGlsZSAodHJ1ZSkgewoJCWJvb2wgb2s7CgkJdWludDY0X3QgZmlyc3QgPSBhdG9taWNf
bG9hZF9leHBsaWNpdChoZWFkLAoJCQkJbWVtb3J5X29yZGVyX2FjcXVpcmUpOwoKCQlpZiAoIWZp
cnN0KQoJCQlyZXR1cm4gTlVMTDsKCgkJb2sgPSBhdG9taWNfY29tcGFyZV9leGNoYW5nZV9zdHJv
bmdfZXhwbGljaXQoaGVhZCwgJmZpcnN0LCAwVUwsCgkJCQltZW1vcnlfb3JkZXJfcmVsZWFzZSwg
bWVtb3J5X29yZGVyX3JlbGF4ZWQpOwoJCWFzc2VydChvayk7CgkJcmV0dXJuICh1aW50NjRfdCAq
KShmaXJzdCk7Cgl9Cn0KCi8qKgogKiBhdG9taWNfc3RhY2tfZ2MgLSByZW1vdmUgcG9wcGVkL2Rl
bGV0ZWQgZWxlbWVudHMgZnJvbSB0aGUgc3RhY2sKICogQGhlYWQgLSBhIHBvaW50ZXIgdG8gdGhl
IGhlYWQgb2YgdGhlIHN0YWNrLgogKiAKICogTm90ZTogaXQgaXMgbW9zdCBsaWtlbHkgdW5zYWZl
IHRvIHJ1biBzZXZlcmFsIGluc3RhbmNlcwogKiBvZiBhdG9taWNfc3RhY2tfZ2MoKSBjb25jdXJy
ZW50bHksIGJ1dCBhIHNpbmdsZSBpbnN0YW5jZQogKiBzaG91bGQgYmUgc2FmZSB0byBydW4gY29u
Y3VycmVudGx5IHdpdGggcHVzaC9wb3AvcmVtb3ZlLgogKi8Kc3RhdGljIGlubGluZSB2b2lkIGF0
b21pY19zdGFja19nYyh1aW50NjRfdCAqaGVhZCkKewoJdWludDY0X3QgKnByZXYgPSBoZWFkOwoK
CXdoaWxlICh0cnVlKSB7CgkJdWludDY0X3QgY3VyciwgbmV4dDsKCgkJYXNzZXJ0ICghKDFVTCAm
ICh1aW50NjRfdClwcmV2KSk7CgkJY3VyciA9IGF0b21pY19sb2FkX2V4cGxpY2l0KHByZXYsIG1l
bW9yeV9vcmRlcl9hY3F1aXJlKTsKCgkJaWYgKCFjdXJyKQoJCQlyZXR1cm47CgoJCWlmIChjdXJy
ICYgMVVMKSB7CgkJCXByZXYgPSBoZWFkOyAgLyogcHJldiBtYXJrZWQgZGVsZXRlZDsgcmVzdGFy
dCAqLwoJCQljb250aW51ZTsKCQl9CgoJCW5leHQgPSBhdG9taWNfbG9hZF9leHBsaWNpdCgodWlu
dDY0X3QgKiljdXJyLCBtZW1vcnlfb3JkZXJfYWNxdWlyZSk7CgkJaWYgKCFuZXh0KQoJCQlyZXR1
cm47CgoJCWlmIChuZXh0ICYgMVVMKSB7ICAvKiBjdXJyIG1hcmtlZCBkZWxldGVkICovCgkJCWlm
IChhdG9taWNfY29tcGFyZV9leGNoYW5nZV9zdHJvbmdfZXhwbGljaXQocHJldiwKCQkJCQkmY3Vy
ciwgbmV4dCAmIH4xVUwsCgkJCQkJbWVtb3J5X29yZGVyX3JlbGVhc2UsCgkJCQkJbWVtb3J5X29y
ZGVyX3JlbGF4ZWQpKSB7CgkJCQljb250aW51ZTsKCQkJfQoKCQkJcHJldiA9IGhlYWQ7ICAvKiBw
cmV2IG1hcmtlZCBhcyBkZWxldGVkOyByZXN0YXJ0ICovCgkJCWNvbnRpbnVlOwoJCX0KCgkJcHJl
diA9ICh1aW50NjRfdCAqKWN1cnI7Cgl9Cn0KCnN0YXRpYyBpbmxpbmUgdm9pZCBhdG9taWNfc3Rh
Y2tfcHJpbnQodWludDY0X3QgKmhlYWQsIGNvbnN0IGNoYXIgKmN0eCkKewoJdWludDY0X3QgY3Vy
ciA9ICh1aW50NjRfdCloZWFkOwoKaW50IGNudCA9IDA7CglmcHJpbnRmKHN0ZGVyciwgIiVzIHN0
YWNrOiAiLCBjdHgpOwoJZG8gewppZiAoKytjbnQgPiA2KSBicmVhazsKCQlmcHJpbnRmKHN0ZGVy
ciwgIjB4JWx4ID0+ICIsIGN1cnIpOwoKCQlpZiAoY3VyciAmIDFVTCkKCQkJY3VyciAmPSB+MVVM
OwoKCQlpZiAoIWN1cnIpCgkJCWJyZWFrOwoKCQljdXJyID0gKih1aW50NjRfdCAqKWN1cnI7Cgl9
IHdoaWxlIChjdXJyKTsKCglmcHJpbnRmKHN0ZGVyciwgIiAobmlsKVxuIik7Cn0KCiNlbmRpZiAg
LyogX19BVE9NSUNfU1RBQ0tfSCAqLwo=
--00000000000000512205c77f31f3--

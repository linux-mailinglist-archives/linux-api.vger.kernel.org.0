Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6699935F5B5
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 16:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348068AbhDNN70 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349262AbhDNN7Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 09:59:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F53C061756
        for <linux-api@vger.kernel.org>; Wed, 14 Apr 2021 06:58:55 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a25so10094312ljm.11
        for <linux-api@vger.kernel.org>; Wed, 14 Apr 2021 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3TW/VUxpoop3CV7OBSruiVlDrYQhCUzznkHnE/1dpw=;
        b=hCqPhJEbqW3DalT0QlHdxLYYZmZltgIWVbrVJdZyEBC/vsvXuhAJSx0lxbfxV9or2G
         fVLnv84ZewjwDGufJ/Si72WQU2XPW8RakxXyRNTmkHjWY+7IcXC8AR59TxJdzY4wzFBO
         IqCZflBvHojbxtZdyqwpuYfqDCjFsrIqH9ld0jFl6quEiJd2tahRPgTUyRqi2DG895mz
         oqvhH1h8ebWRKEMx6Xp8Uu90WmgyaNYJddcAH6zuR3+1ehRk5FYS2X18BtbnK1Fw8yPX
         kBFs+ctV6Ert/VRhSY8GW+c/KCAcVveBrUyhYyPMYP/2O8dyGvDEFWlLtEMzo8k0sALT
         tdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3TW/VUxpoop3CV7OBSruiVlDrYQhCUzznkHnE/1dpw=;
        b=ulbd0rPDVUUl12Rd+w/eRPz3VDRfBYpUObFzagL0b1oJxpZK4Bn51ptDkLJ8YPy8R7
         LOM3WVS2pHeAowvLiuw2F4hjg//pwqpbSOXlxh3eqi8GauvFOwJiA0svj5Io4JDMhwIk
         yj9bbCNYdsgEk21oqZcOJ4HuqSbXU1g1CpRWtnpFLMEUxZ+vcQ+wo8j8+X9It+ldQCWM
         CK5u/elj2Ap+J3zFw/M78IkwcfsObPJBeiWia7egYUtkSdmYWa7DFdwfq9EUFxK9l6bC
         J419O80G1BskAWmNGdsEaFgh0o4ylcSJPltN1M31QB/yidnhZsCOIuyZ5AlOdIupHiYU
         jU7g==
X-Gm-Message-State: AOAM533ioNEqsiMRG1UxUBp6qFKB07yS5K5W+2az/CtDtU2BEvEiW4ka
        jRWgr2+rCGRFKVIMEokaOPG8hSgNM31GRVoAK/RVNw==
X-Google-Smtp-Source: ABdhPJzXiYnByYOweKPqo5V02GydcVPisdDJJyVyHIX7nHY7WjJeSeDlPhH97SgaPRAM81x4DVGA8rFaYsqMb0kpCNA=
X-Received: by 2002:a2e:7607:: with SMTP id r7mr10786299ljc.226.1618408733362;
 Wed, 14 Apr 2021 06:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com> <87blahb1pr.fsf@oldenburg.str.redhat.com>
 <CAG48ez2z0a4x2GfHv9L0HmO1-uzsKtfOF40erPb8ADR-m+itbg@mail.gmail.com> <874kg99hwf.fsf@oldenburg.str.redhat.com>
In-Reply-To: <874kg99hwf.fsf@oldenburg.str.redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 14 Apr 2021 15:58:25 +0200
Message-ID: <CAG48ez02UDn_yeLuLF4c=kX0=h2Qq8Fdb0cer1yN8atbXSNjkQ@mail.gmail.com>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-um@lists.infradead.org, criu@openvz.org,
        Andrei Vagin <avagin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 On Wed, Apr 14, 2021 at 2:20 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Jann Horn:
>
> > On Wed, Apr 14, 2021 at 12:27 PM Florian Weimer <fweimer@redhat.com> wrote:
> >>
> >> * Andrei Vagin:
> >>
> >> > We already have process_vm_readv and process_vm_writev to read and write
> >> > to a process memory faster than we can do this with ptrace. And now it
> >> > is time for process_vm_exec that allows executing code in an address
> >> > space of another process. We can do this with ptrace but it is much
> >> > slower.
> >> >
> >> > = Use-cases =
> >>
> >> We also have some vaguely related within the same address space: running
> >> code on another thread, without modifying its stack, while it has signal
> >> handlers blocked, and without causing system calls to fail with EINTR.
> >> This can be used to implement certain kinds of memory barriers.
> >
> > That's what the membarrier() syscall is for, right? Unless you don't
> > want to register all threads for expedited membarrier use?
>
> membarrier is not sufficiently powerful for revoking biased locks, for
> example.

But on Linux >=5.10, together with rseq, it is, right? Then lock
acquisition could look roughly like this, in pseudo-C (yes, I know,
real rseq doesn't quite look like that, you'd need inline asm for that
unless the compiler adds special support for this):


enum local_state {
  STATE_FREE_OR_BIASED,
  STATE_LOCKED
};
#define OWNER_LOCKBIT (1U<<31)
#define OWNER_WAITER_BIT (1U<<30) /* notify futex when OWNER_LOCKBIT
is cleared */
struct biased_lock {
  unsigned int owner_with_lockbit;
  enum local_state local_state;
};

void lock(struct biased_lock *L) {
  unsigned int my_tid = THREAD_SELF->tid;
  RSEQ_SEQUENCE_START(); // restart here on failure
  if (READ_ONCE(L->owner) == my_tid) {
    if (READ_ONCE(L->local_state) == STATE_LOCKED) {
      RSEQ_SEQUENCE_END();
      /*
       * Deadlock, abort execution.
       * Note that we are not necessarily actually *holding* the lock;
       * this can also happen if we entered a signal handler while we
       * were in the process of acquiring the lock.
       * But in that case it could just as well have happened that we
       * already grabbed the lock, so the caller is wrong anyway.
       */
      fatal_error();
    }
    RSEQ_COMMIT(L->local_state = STATE_LOCKED);
    return; /* fastpath success */
  }
  RSEQ_SEQUENCE_END();

  /* slowpath */
  /* acquire and lock owner field */
  unsigned int old_owner_with_lockbit;
  while (1) {
    old_owner_with_lockbit = READ_ONCE(L->owner_with_lockbit);
    if (old_owner_with_lockbit & OWNER_LOCKBIT) {
      if (!__sync_bool_compare_and_swap (&L->owner_with_lockbit,
old_owner_with_lockbit, my_tid | OWNER_LOCKBIT | OWNER_WAITER_BIT))
       continue;
      futex(&L->owner_with_lockbit, FUTEX_WAIT,
old_owner_with_lockbit, NULL, NULL, 0);
      continue;
    } else {
      if (__sync_bool_compare_and_swap (&L->owner_with_lockbit,
old_owner_with_lockbit, my_tid | OWNER_LOCKBIT))
        break;
    }
  }

  /*
   * ensure old owner won't lock local_state anymore.
   * we only have to worry about the owner that directly preceded us here;
   * it will have done this step for the owners that preceded it before clearing
   * the LOCKBIT; so if we were the old owner, we don't have to sync.
   */
  if (old_owner_with_lockbit != my_tid) {
    if (membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ, 0, 0))
      fatal_error();
  }

  /*
   * As soon as the lock becomes STATE_FREE_OR_BIASED, we own it; but
   * at this point it might still be locked.
   */
  while (READ_ONCE(L->local_state) == STATE_LOCKED) {
    futex(&L->local_state, FUTEX_WAIT, STATE_LOCKED, NULL, NULL, 0);
  }

  /* OK, now the lock is biased to us and we can grab it. */
  WRITE_ONCE(L->local_state, STATE_LOCKED);

  /* drop lockbit */
  unsigned int old_owner_with_lockbit;
  while (1) {
    old_owner_with_lockbit = READ_ONCE(L->owner_with_lockbit);
    if (__sync_bool_compare_and_swap (&L->owner_with_lockbit,
old_owner_with_lockbit, my_tid))
      break;
  }
  if (old_owner_with_lockbit & OWNER_WAITER_BIT)
    futex(&L->owner_with_lockbit, FUTEX_WAKE, INT_MAX, NULL, NULL, 0);
}

void unlock(struct biased_lock *L) {
  unsigned int my_tid = THREAD_SELF->tid;

  /*
   * If we run before the membarrier(), the lock() path will immediately
   * see the lock as uncontended, and we don't need to call futex().
   * If we run after the membarrier(), the ->owner_with_lockbit read
   * here will observe the new owner and we'll wake the futex.
   */
  RSEQ_SEQUENCE_START();
  unsigned int old_owner_with_lockbit = READ_ONCE(L->owner_with_lockbit);
  RSEQ_COMMIT(WRITE_ONCE(L->local_state, STATE_FREE_OR_BIASED));
  if (old_owner_with_lockbit != my_tid)
    futex(&L->local_state, FUTEX_WAKE, INT_MAX, NULL, NULL, 0);
}

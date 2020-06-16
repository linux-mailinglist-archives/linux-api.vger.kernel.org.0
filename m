Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B88E1FAFF8
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 14:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFPMPW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 08:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgFPMPS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 08:15:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47C8C08C5C4
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 05:15:16 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x18so23195011lji.1
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lId2VqgWnSj5hcyOUSdipcvBeLlaT4UQgOgtGOYEhak=;
        b=s1Xvol0hq1EOoKeJihXOkMd72MbgzGDi/AYBydiHucg2rKev+h0cN2w6F1lmaJLfF7
         2LVZS3A1TRtzSbwJjVUdPfbMu275KD7VR8+NJ6MIGv9XrItrc3KQq5z4P5w5LxzRRV0b
         SKxXhp+NiJbbuoGqXlAp3egwbRyD9nt8nsY551sk3YR1vcXco5WbUHAYFZO6CmEaR8kc
         J+pOUxODJERuU3o74KnAYANuo6GfzDdgCBtAq+Ot8dNTfFcW+DvGnR1F56ugfzAC1cB1
         ZghfX5C3ihyc22918h8plqPmbDXYit3e+p07Im8MqqpB+6cD1mvze8eVe0LIMM7Zbd3d
         MmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lId2VqgWnSj5hcyOUSdipcvBeLlaT4UQgOgtGOYEhak=;
        b=ejyt6uOGA+xTZN/TTo53oBqF/NJK2QcqfhglSMX8NN5whaLLkdaCMY1EaPWvBOmnD2
         LhdrJYg194+2Bxao+lIIiFo+a3dtS0KNOGfZ1JXDH1Cw1Aut4R1KJGfIoS3ucHaC4cxN
         LiK7PFyQ6XlVzNjS3iWw4qQh9vW4L2p1sS9OU57CrGz8IOnKQ39waA9UlOEI9Y7S1KdA
         hFP7ZA8Hmquoxmj3NOMg2M//0RIuFXeTyXQMR/lxF8mPT2mzxuLfYwZL3T6adnn9BNwy
         c1VUhynnrJSeJZLcX14PMS2K5M23rfbB6PeVTtjyFvOvRNF/NMonUVIqXXXcLyWmg+vk
         1UGg==
X-Gm-Message-State: AOAM530A7LCXDK0Kmchjr31StLjaiBl4p7kAmlM+43GGR+062boeZ46v
        2HBqmypTID6pe3xWvQWISHCGr82HHlflJlLno4JTTA==
X-Google-Smtp-Source: ABdhPJxDrDxH93vuVXYIp6o+fe2nZXY74IHAWLTSSyziCuq+my4CnIzXCk2zf8Bfhk8nYT9ozFWEI14WQpKH3FLnqiE=
X-Received: by 2002:a05:651c:c9:: with SMTP id 9mr1390777ljr.365.1592309714391;
 Tue, 16 Jun 2020 05:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200616074934.1600036-1-keescook@chromium.org> <20200616074934.1600036-5-keescook@chromium.org>
In-Reply-To: <20200616074934.1600036-5-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 16 Jun 2020 14:14:47 +0200
Message-ID: <CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com>
Subject: Re: [PATCH 4/8] seccomp: Implement constant action bitmaps
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 16, 2020 at 9:49 AM Kees Cook <keescook@chromium.org> wrote:
> One of the most common pain points with seccomp filters has been dealing
> with the overhead of processing the filters, especially for "always allow"
> or "always reject" cases. While BPF is extremely fast[1], it will always
> have overhead associated with it. Additionally, due to seccomp's design,
> filters are layered, which means processing time goes up as the number
> of filters attached goes up.
>
> In the past, efforts have been focused on making filter execution complete
> in a shorter amount of time. For example, filters were rewritten from
> using linear if/then/else syscall search to using balanced binary trees,
> or moving tests for syscalls common to the process's workload to the
> front of the filter. However, there are limits to this, especially when
> some processes are dealing with tens of filters[2], or when some
> architectures have a less efficient BPF engine[3].
>
> The most common use of seccomp, constructing syscall block/allow-lists,
> where syscalls that are always allowed or always rejected (without regard
> to any arguments), also tends to produce the most pathological runtime
> problems, in that a large number of syscall checks in the filter need
> to be performed to come to a determination.
>
> In order to optimize these cases from O(n) to O(1), seccomp can
> use bitmaps to immediately determine the desired action. A critical
> observation in the prior paragraph bears repeating: the common case for
> syscall tests do not check arguments. For any given filter, there is a
> constant mapping from the combination of architecture and syscall to the
> seccomp action result. (For kernels/architectures without CONFIG_COMPAT,
> there is a single architecture.). As such, it is possible to construct
> a mapping of arch/syscall to action, which can be updated as new filters
> are attached to a process.
>
> In order to build this mapping at filter attach time, each filter is
> executed for every syscall (under each possible architecture), and
> checked for any accesses of struct seccomp_data that are not the "arch"
> nor "nr" (syscall) members. If only "arch" and "nr" are examined, then
> there is a constant mapping for that syscall, and bitmaps can be updated
> accordingly. If any accesses happen outside of those struct members,
> seccomp must not bypass filter execution for that syscall, since program
> state will be used to determine filter action result.
>
> During syscall action probing, in order to determine whether other members
> of struct seccomp_data are being accessed during a filter execution,
> the struct is placed across a page boundary with the "arch" and "nr"
> members in the first page, and everything else in the second page. The
> "page accessed" flag is cleared in the second page's PTE, and the filter
> is run. If the "page accessed" flag appears as set after running the
> filter, we can determine that the filter looked beyond the "arch" and
> "nr" members, and exclude that syscall from the constant action bitmaps.
>
> For architectures to support this optimization, they must declare
> their architectures for seccomp to see (via SECCOMP_ARCH and
> SECCOMP_ARCH_COMPAT macros), and provide a way to perform efficient
> CPU-local kernel TLB flushes (via local_flush_tlb_kernel_range()),
> and then set HAVE_ARCH_SECCOMP_BITMAP in their Kconfig.

Wouldn't it be simpler to use a function that can run a subset of
seccomp cBPF and bails out on anything that indicates that a syscall's
handling is complex or on instructions it doesn't understand? For
syscalls that have a fixed policy, a typical seccomp filter doesn't
even use any of the BPF_ALU ops, the scratch space, or the X register;
it just uses something like the following set of operations, which is
easy to emulate without much code:

BPF_LD | BPF_W | BPF_ABS
BPF_JMP | BPF_JEQ | BPF_K
BPF_JMP | BPF_JGE | BPF_K
BPF_JMP | BPF_JGT | BPF_K
BPF_JMP | BPF_JA
BPF_RET | BPF_K

Something like (completely untested):

/*
 * Try to statically determine whether @filter will always return a fixed result
 * when run for syscall @nr under architecture @arch.
 * Returns true if the result could be determined; if so, the result will be
 * stored in @action.
 */
static bool seccomp_check_syscall(struct sock_filter *filter, unsigned int arch,
                                  unsigned int nr, unsigned int *action)
{
  int pc;
  unsigned int reg_value = 0;

  for (pc = 0; 1; pc++) {
    struct sock_filter *insn = &filter[pc];
    u16 code = insn->code;
    u32 k = insn->k;

    switch (code) {
    case BPF_LD | BPF_W | BPF_ABS:
      if (k == offsetof(struct seccomp_data, nr)) {
        reg_value = nr;
      } else if (k == offsetof(struct seccomp_data, arch)) {
        reg_value = arch;
      } else {
        return false; /* can't optimize (non-constant value load) */
      }
      break;
    case BPF_RET | BPF_K:
      *action = insn->k;
      return true; /* success: reached return with constant values only */
    case BPF_JMP | BPF_JA:
      pc += insn->k;
      break;
    case BPF_JMP | BPF_JEQ | BPF_K:
    case BPF_JMP | BPF_JGE | BPF_K:
    case BPF_JMP | BPF_JGT | BPF_K:
    default:
      if (BPF_CLASS(code) == BPF_JMP && BPF_SRC(code) == BPF_K) {
        u16 op = BPF_OP(code);
        bool op_res;

        switch (op) {
        case BPF_JEQ:
          op_res = reg_value == k;
          break;
        case BPF_JGE:
          op_res = reg_value >= k;
          break;
        case BPF_JGT:
          op_res = reg_value > k;
          break;
        default:
          return false; /* can't optimize (unknown insn) */
        }

        pc += op_res ? insn->jt : insn->jf;
        break;
      }
      return false; /* can't optimize (unknown insn) */
    }
  }
}

That way, you won't need any of this complicated architecture-specific stuff.

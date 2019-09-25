Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA54BE3BC
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 19:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfIYRsx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 13:48:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41535 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfIYRsx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 13:48:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so4868447lfn.8
        for <linux-api@vger.kernel.org>; Wed, 25 Sep 2019 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ubp3hpdHZYFHNsbBzmSC09eT5vsyQ7Zrdz0nsHZMrVo=;
        b=gGKQ4rsBGdlqZUFMO6XNkNge3CFyTMn8oZRzwJk/rovTd8qu09JoOmMh4pWLsauLni
         Au3XxhldtMZLJwfaqs4pnNxXd0RGKaYu+YhlrWEfuThVz+0g8mr0CzD/B99CmJ3YtiNy
         rZkgmAhinraPdfB5emwIyaHr2/x37VdH3uCq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ubp3hpdHZYFHNsbBzmSC09eT5vsyQ7Zrdz0nsHZMrVo=;
        b=FPqmfKK4ijGEK+wDipepO36JdwdtZtrZwNoS2kC4NvtrGOL06xCW0xNl+X2koIO/m6
         E2XY0eyTCS0gPGKtyT5qRzfi35ypdDpnQDe1fRx/0W17qOFL79k5wFNS1DDlz9CKjUaY
         PhKFcu2cLHUTDng8IvSxilzPe2TBGUfWE4cnnHlWhjem7WFXiqS+N2c5/hrux7rlyC0b
         2/ZxN2/fSy62LnAnSHqFUDZ7o8QDZScBmI0sxAoqxSsKGJzwUmHqlijqLTt1UPfl6cw2
         +a/ZVgAC5+R/vigWeXPWCKXEh6f2Yz7AA9UqFZ2I3vstnuTWcT91lOjO49H5FsFIVuT1
         GYjQ==
X-Gm-Message-State: APjAAAVFZnABGTwcysfAjxmjuMYeaCsfR5gZikQe2BDFDTmcyJCxsfYf
        +rcCS2/zJAIvAKxUFoTrTKwCziZTt7E=
X-Google-Smtp-Source: APXvYqx2M4w0p0FwuXzpX2Db8FIS8Gjvf7Wvlto61ehlS6HX7tADeJk4wH9QnLqbQBUc6dVVVTLcEQ==
X-Received: by 2002:ac2:43c5:: with SMTP id u5mr7005815lfl.47.1569433730207;
        Wed, 25 Sep 2019 10:48:50 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id e19sm1368759lja.8.2019.09.25.10.48.48
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 10:48:48 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c195so4869903lfg.9
        for <linux-api@vger.kernel.org>; Wed, 25 Sep 2019 10:48:48 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr7038976lfp.61.1569433727828;
 Wed, 25 Sep 2019 10:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190925165915.8135-1-cyphar@cyphar.com> <20190925165915.8135-2-cyphar@cyphar.com>
 <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com> <20190925172049.skm6ohnnxpofdkzv@yavin>
In-Reply-To: <20190925172049.skm6ohnnxpofdkzv@yavin>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Sep 2019 10:48:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
Message-ID: <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 25, 2019 at 10:21 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> Just to make sure I understand, the following diff would this solve the
> problem? If so, I'll apply it, and re-send in a few hours.

Actually, looking at it more, it's still buggy.

That final "size smaller than unsigned long" doesn't correctly handle
the case of (say) a single byte in the middle of a 8-byte word.

So you need to do something like this:

    int is_zeroed_user(const void __user *from, size_t size)
  {
        unsigned long val, mask, align;

        if (unlikely(!size))
                return true;

        if (!user_access_begin(from, size))
                return -EFAULT;

        align = (uintptr_t) from % sizeof(unsigned long);
        from -= align;
        size += align;

        mask = ~aligned_byte_mask(align);

        while (size >= sizeof(unsigned long)) {
                unsafe_get_user(val, (unsigned long __user *) from, err_fault);
                val &= mask;
                if (unlikely(val))
                        goto done;
                mask = ~0ul;
                from += sizeof(unsigned long);
                size -= sizeof(unsigned long);
        }

        if (size) {
                /* (@from + @size) is unaligned. */
                unsafe_get_user(val, (unsigned long __user *) from, err_fault);
                mask &= aligned_byte_mask(size);
                val &= mask;
        }

  done:
        user_access_end();
        return (val == 0);
  err_fault:
        user_access_end();
        return -EFAULT;
  }

note how "mask" carries around from the very beginning all the way to
the end, and "align" itself is no longer used after mask has been
calculated.

That's required because of say a 2-byte read at offset 5. You end up
with "align=5, size=7" at the beginning, and mask needs to be
0x00ffff0000000000 (on little-endian) for that final access.

Anyway, I checked, and the above seems to generate ok code quality
too. Sadly "unsafe_get_user()" cannot use "asm goto" because of a gcc
limitation (no asm goto with outputs), so it's not _perfect_, but
that's literally a compiler limitation.

But I didn't actually _test_ the end result. You should probably
verify that it gets the right behavior exactly for those interesting
cases where we mask both the beginning and the end.

            Linus

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70FAD166B35
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2020 00:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgBTX4W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 18:56:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41049 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbgBTX4W (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 18:56:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so153215eds.8
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 15:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNDEYAC7DB9YZj2gZI9Z6zcgcjYXY0WlNUd/lj4aAPs=;
        b=XXGyT2OTWpB64th/vPVkrN8ruW2f9cZk6TbylbolgAVKvklROGPImgdexYcm7PLy+f
         BQTWWPL1F3qIN7l3Dq0t9Uu68LaVEjTVVH3auFqU7GxZPXIvpkmrC16+4Z1H1cJOebL5
         Lvo1QJHLtGwmVRsdCOiaMRq4DYeqlDXcfrVJdD7R2pwkOZREAbrYu4uO69FSE1NQjX41
         LHAhCWZNeW5WU9pBAp27tB02+HKXN20P76igbJaaQi0x/nItXf1MM5UocyVhxVMtvBJ3
         ayy3sAy5iev4TWkVL/NJTUQfH2mnlc/NEqADgydaiOsyVsK7eC5LwvaXHBbFhtT3g4wp
         4ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNDEYAC7DB9YZj2gZI9Z6zcgcjYXY0WlNUd/lj4aAPs=;
        b=Q9aD9F4kSMt4UdqPXlResk1EHtyBYGNstPraDFD7UnDTnTpHcPJFuK5BbapF0fqFIN
         Invi2o0kzUoOkgXOhR7xJOeifzfP1v+jUfeJJtORd05h0kGuUvNfISiWw7Xuqmrzn2TA
         oCtTyzZVS3WaZFNe3HO34bxW/t9nposSWzVFvB8lhoNjrMCAkBL6ASH0fw6rWGJ6OWBa
         Ti2nAUoYlhTS4ow7SmKQXs7WshcPyf6cAZKz0RppI5zYBvyU1XGghnfcv1Jb8Kf3gFMm
         wKTZHqy1Vj+0aZZ8aYuZ6YZE9BPl3XCXcX/Zw7RGsa21Z1DlFpgITdB6i3Sh39ZsvrV3
         8wQg==
X-Gm-Message-State: APjAAAUMtA8hzWT4BnPjovq7kwckUDaMdAnQaqXB321ws5+8DmY52gGe
        d8LJELmmzV4PHQzS7XVURA3qamIxkEM/QT2R/kTbyQ==
X-Google-Smtp-Source: APXvYqzpKwKC1T9/jdMm4FY8y3lkou+3lv6gj8We0ELkhEzlN9PeYavWhHfqwfiG/wqIc9ypFDi9U3oCF2x+1nSM0Og=
X-Received: by 2002:a05:6402:6c7:: with SMTP id n7mr30390013edy.177.1582242980107;
 Thu, 20 Feb 2020 15:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20200218173221.237674-1-bgeffon@google.com> <20200220115744.ummq6j5ejp5qojic@box>
In-Reply-To: <20200220115744.ummq6j5ejp5qojic@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Thu, 20 Feb 2020 15:55:53 -0800
Message-ID: <CADyq12y2uJh2ROBajA1D5H6OLEyFrKKEXH=yQC-8ELF0+UiNzw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Kirill,

> I have hard time understanding the case when new_len != old_len.
>
> Correct me if I'm wrong, but looks like that you change the size of old
> mapping to be the new_len and then create a new of the same new_len.
>
> This doesn't look right to me.
>
> In my opinion, MREMAP_DONTUNMAP has to leave the old mapping intact. And
> create the new mapping adjusted to the new_len.
>
> Other option is to force new_len == old_len if MREMAP_DONTUNMAP is
> specified. It would simplify the implementation. And I don't see why
> anybody would really want anything else.

I had been approaching this as, "do what mremap would have done in
this situation except skip the last step." Meaning, whatever the final
state of the old mapping was MREMAP_DONTUNMAP meant that you should
just not do the unmap operation on the old mapping at the end. But I
understand why it's confusing, especially when in the case of the VMA
growing you're left with the old vma of size old_len and the new_vma
of size new_len but only containing old_len worth of pages.
Personally, I don't think this is a problem having that behavior
because it can be documented and it just adds a small amount of
flexibility.

Nonetheless, I agree with you and I also cannot come up with a
situation where you'd actually want to do this so I'm willing to
restrict it to old_len == new_len and return -EINVAL if not, it
simplifies it a bit and accounting becomes a easier because the
outcome is always the same two mappings of size old_len and the size
of the locked_vm never changes. We can always allow the resize
operation later if there becomes a need. If everyone is okay with this
restriction I can send a new patch.

Thank you again,
Brian

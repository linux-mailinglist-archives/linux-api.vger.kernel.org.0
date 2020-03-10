Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88F6180628
	for <lists+linux-api@lfdr.de>; Tue, 10 Mar 2020 19:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCJSYi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Mar 2020 14:24:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35756 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJSYi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Mar 2020 14:24:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id a20so11597344edj.2;
        Tue, 10 Mar 2020 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/geXS1ktRmdQ+oZIMa1IAHtn3QcVn0X1vL0uiDn3J4=;
        b=Y4Mv/RG7zokLOwUODFO2Sv/EsmnAk1VZ6R2I1es12dgvA3dk4X/FWJFZtNRWBjxX1c
         tVE1ZflhW3Kp4bjtPKBmvvGeMQBcsZJGTmkv7NDsC+94yefejDo+krJ0mZ6z+rCw29Im
         w5SvEhrJQa6CY2pe6OGXV9OZku2qIrPt4tm7ZbL1pJBuSrlEpdEFvJnaweYP7JX7wsu6
         3EBT1W+V8D13FVYcMyWH69qIrnuH7bI3DBm1p+PPNdmJhjYQ4GyexONkrlvMCfGAsbbb
         1WD62Oo0SFgxKGpMJph4XgLJKb+hluMBN5swYQF3UNmoZ6eQ1R28PSpsdXiZMQLAQm6s
         /hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/geXS1ktRmdQ+oZIMa1IAHtn3QcVn0X1vL0uiDn3J4=;
        b=E9t7CmoRRUkjL/avxO9OWBHHsCwvdJWdxksp0IK7zp02LoKnMp/E8EzuCYp/JUylrf
         ZfseErQYHrJqmVjwoKnuFqJn10nVvY4SyLcT2BSubfHdL6li8i8VtExtvysrdx35EywC
         qyUClegLQQwaR5l+G5nmQlucZkplg7xhlhdhYJgoppi7tUNRE/cKZ9Y3gtVbRW1CiuT8
         FyPCRgE4k1YmO13jwQ9amBHYAJZ5TwTa7TFqxmqPIa7tfpuQ+qnzsBFZEtledoXa3ymJ
         Gl4Zk+qLf0oIf7LPmQf8amCbCBKqTo63AHuD8aSwbjJUCP/fI6MaB2Itz7zgP8vCWnlx
         jPBg==
X-Gm-Message-State: ANhLgQ3L+mSK6ibVwPU/+yWj4bXLb/lSPpjpFm+xqb+qrkYJ7q0ht6Sx
        b6EIyPCQmKMytSxalR7XfcUkgduPiUhIolPLhIgrYA==
X-Google-Smtp-Source: ADFU+vs6jC86jhNiQ9dqBIBIQR+hMKRBT5ajUKABb3eFRrfB1usVWKKbkTyQo55pqkLEuvp3Hn5ZneyFnY3BCe2a92I=
X-Received: by 2002:a17:906:3e0c:: with SMTP id k12mr5881975eji.309.1583864674852;
 Tue, 10 Mar 2020 11:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <1580757507-120233-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200210093635.GC10636@dhcp22.suse.cz> <92f30e24-7b77-b21a-ed3a-efc55bc500c6@linux.alibaba.com>
In-Reply-To: <92f30e24-7b77-b21a-ed3a-efc55bc500c6@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 10 Mar 2020 11:24:21 -0700
Message-ID: <CAHbLzkpc4huH2J8xT0PCSGJba_WkWX-e3dtWQO7-Xi9aMTEV5w@mail.gmail.com>
Subject: Re: [v3 PATCH] move_pages.2: Returning positive value is a new error case
To:     mtk.manpages@gmail.com
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>, david@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 20, 2020 at 9:07 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>
>
> On 2/10/20 1:36 AM, Michal Hocko wrote:
> > On Tue 04-02-20 03:18:27, Yang Shi wrote:
> >> Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
> >> the semantic of move_pages() has changed to return the number of
> >> non-migrated pages if they were result of a non-fatal reasons (usually a
> >> busy page).  This was an unintentional change that hasn't been noticed
> >> except for LTP tests which checked for the documented behavior.
> >>
> >> There are two ways to go around this change.  We can even get back to the
> >> original behavior and return -EAGAIN whenever migrate_pages is not able
> >> to migrate pages due to non-fatal reasons.  Another option would be to
> >> simply continue with the changed semantic and extend move_pages
> >> documentation to clarify that -errno is returned on an invalid input or
> >> when migration simply cannot succeed (e.g. -ENOMEM, -EBUSY) or the
> >> number of pages that couldn't have been migrated due to ephemeral
> >> reasons (e.g. page is pinned or locked for other reasons).
> >>
> >> We decided to keep the second option in kernel because this behavior is in
> >> place for some time without anybody complaining and possibly new users
> >> depending on it.  Also it allows to have a slightly easier error handling
> >> as the caller knows that it is worth to retry when err > 0.
> >>
> >> Update man pages to reflect the new semantic.
> >>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> >> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>

Hi Michale,

Maybe my work email went to your spam folder. So, ping with my
personal email. Would you please consider take this patch?

Thanks,
Yang

> Hi Michael,
>
> Would you please consider take this patch? The kernel change has been
> upstreamed.
>
> Thanks,
> Yang
>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> >> ---
> >> v3: * Fixed the comments from David Hildenbrand.
> >>      * Fixed the inaccuracy about pre-initialized status array values.
> >> v2: * Added notes about status array per Michal.
> >>      * Added Michal's Acked-by.
> >>
> >>   man2/move_pages.2 | 10 ++++++++--
> >>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/man2/move_pages.2 b/man2/move_pages.2
> >> index 1bf1053..50c83a4 100644
> >> --- a/man2/move_pages.2
> >> +++ b/man2/move_pages.2
> >> @@ -104,7 +104,9 @@ pages that need to be moved.
> >>   is an array of integers that return the status of each page.
> >>   The array contains valid values only if
> >>   .BR move_pages ()
> >> -did not return an error.
> >> +did not return an error.  Pre-initialization of the array to the value
> >> +which cannot represent a real numa node or valid error of status array
> >> +could help to identify pages that have been migrated
> >>   .PP
> >>   .I flags
> >>   specify what types of pages to move.
> >> @@ -164,9 +166,13 @@ returns zero.
> >>   .\" do the right thing?
> >>   On error, it returns \-1, and sets
> >>   .I errno
> >> -to indicate the error.
> >> +to indicate the error. If positive value is returned, it is the number of
> >> +non-migrated pages.
> >>   .SH ERRORS
> >>   .TP
> >> +.B Positive value
> >> +The number of non-migrated pages if they were the result of non-fatal
> >> +reasons (since version 4.17).
> >>   .B E2BIG
> >>   Too many pages to move.
> >>   Since Linux 2.6.29,
> >> --
> >> 1.8.3.1
>

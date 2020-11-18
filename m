Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACDB2B84E1
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 20:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKRTWe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 14:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKRTWd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Nov 2020 14:22:33 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E305C0613D4
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 11:22:33 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so4126174wml.5
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 11:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5dNLVflsoCWnQaHKvWs9L85VwqNp8UsUbv9wLjV6qI=;
        b=CSfiTZgwKRZkrhto0srzY8T5NgHeQ5ORWlbLYsBr+wleRBGDbQDMXoZAaO0ImJkt44
         jwnxeYw9ySf6N0viXo1ZcV64DhaoZ0waV3olM/pLP9EoWTCMkWpn1fvzhj7igXt+RiKS
         aRYG8y/aHSDoPLPigh7MEIoTmW4wkXE3u3bjIyAtzAPAEKeO4naRZ2sJSyH7urs+Ujsr
         pCZNfHkkc4U5LhbQLLyiyqN4BRxyn7xaCOK5xs9LvJ6pGS0EGLTdkaym2GHKptayy67e
         9FNlpEBX72O6mZZnO8CLkmo1z52bU6CnYLzM9eHk8pCVaHrzCjx2IPnSPK6v+oK7aM6c
         xKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5dNLVflsoCWnQaHKvWs9L85VwqNp8UsUbv9wLjV6qI=;
        b=g6z1RksLMtwVA7doPQxBmJxciIjtpoc/xZp+uHD/eYemd8qiTW+4lskBh5lLvMs7uD
         pLbFqoq1KpPAGLONtT+NorvZzgrzg1LM0jBR7DW3aIu2w/4Z9/eRNRqu9ZHCqkeStSxC
         NVzlkH6a1b+FOUZnIVKtBFt36YoDAfjL0DVtah8SafssuqjRQMZSVRZXeqB9wQMiodDG
         p/xuG+BinE7k1Ivynrh5AMjH4AzZEWwPd4wfrsuAcHzdenMGmrHkBPrIoCErf9d1yYg6
         0z9WoEIRdNJ5DNKi5cp311+DOKT8gB7CxSN7q6ozaAAhKfX3pLm+O6bO2qaOftlHGxQN
         EQXw==
X-Gm-Message-State: AOAM532oRv7oRQZgix+mBROSgLii5/MFMFKepP2//zyH0DzTpE/5S+sO
        s9q7yrqR0Ibkr4bWDniBj6k47DrsKIZpsw+EQeTeUg==
X-Google-Smtp-Source: ABdhPJzHNJdt2+p/Yo25GoJt90AE0ooYZPZ68TX49xvJioavYYVR8ran9z9fFt/Dpl/fTIF6NbpaoSWngZlQbFpfAtY=
X-Received: by 2002:a1c:e3c1:: with SMTP id a184mr660962wmh.88.1605727352121;
 Wed, 18 Nov 2020 11:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20201113173448.1863419-1-surenb@google.com> <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
 <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
 <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
 <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
 <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
 <CAJuCfpH-Qjm5uqfaUcfk0QV2zC76uL96FQjd88bZGBvCuXE_aA@mail.gmail.com>
 <20201113181632.6d98489465430a987c96568d@linux-foundation.org> <20201118154334.GT12284@dhcp22.suse.cz>
In-Reply-To: <20201118154334.GT12284@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Nov 2020 11:22:21 -0800
Message-ID: <CAJuCfpGC1Kv2rC7oq-TT2dX1soy5J_R+y6DU8xEzVuJgOqHKAw@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 18, 2020 at 11:10 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 13-11-20 18:16:32, Andrew Morton wrote:
> [...]
> > It's all sounding a bit painful (but not *too* painful).  But to
> > reiterate, I do think that adding the ability for a process to shoot
> > down a large amount of another process's memory is a lot more generally
> > useful than tying it to SIGKILL, agree?
>
> I am not sure TBH. Is there any reasonable usecase where uncoordinated
> memory tear down is OK and a target process which is able to see the
> unmapped memory?

I think uncoordinated memory tear down is a special case which makes
sense only when the target process is being killed (and we can enforce
that by allowing MADV_DONTNEED to be used only if the target process
has pending SIGKILL). However, the ability to apply other flavors of
process_madvise() to large memory areas spanning multiple VMAs can be
useful in more cases. For example in Android we will use
process_madvise(MADV_PAGEOUT) to "shrink" an inactive background
process. Today we have to read /proc/maps and construct the vector of
VMAs even when applying this advice to the entire process. With such a
special mode we could achieve this more efficiently and with less
hussle.

> --
> Michal Hocko
> SUSE Labs

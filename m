Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21068304804
	for <lists+linux-api@lfdr.de>; Tue, 26 Jan 2021 20:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388849AbhAZFw7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 00:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbhAZCDc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 Jan 2021 21:03:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC51BC0613ED
        for <linux-api@vger.kernel.org>; Mon, 25 Jan 2021 16:14:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y187so1156554wmd.3
        for <linux-api@vger.kernel.org>; Mon, 25 Jan 2021 16:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vz7Wx3SXxaN+HsWZGzhnHFVDxGZAroM2JwH4bW0nEhM=;
        b=WulKks/yUSJwwUol1tm6wB9TJkukXvTYKvdB2ceQgXomgHQMSU12Q0ukxoGukdPNr8
         HGAjlTfWtd5HvJzNWyfyy0crd2HH+/syiXerMgHWpnjKX2vL/MjmxngjAkb9Ff2XGB5O
         2/Kvk7D9kj7xdMH5EBWmOi+BQjBDhtTEW1Gfpa+yh52P9hNpbK7Lr+NmN28rhnuHGel+
         dO62MQLsOV4fBk09tq1r4tc2zrJUdUMA+jCyQbkJYdTVuaGSVsKAM9Ytr4Ozzu8qwh3t
         JdPEfNF7P53HhUk4Nx0zB6G5G3rIGu1xvUCi6Vt61QOVMpU8sH7py/rv4XF0bp+yCvWD
         rXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz7Wx3SXxaN+HsWZGzhnHFVDxGZAroM2JwH4bW0nEhM=;
        b=pl6xWw8rpN1XZfzZuO9CdDfnnfmrP2CAnhFvChc+CFvNASYwbJ6FwgEERYJHgEh5s2
         /CfbF2S2MCGUTjtdKPMK6LmhXPnRrDX/m5yYcwFlgpBWLYMHJFMjbqB+4FpZsUptD+A/
         PxbXvUnt/CcMwsYbqPlSvbWm9CW632W5wX3txhdX09UYbQ+y2EuIMEudL4carHtbwnKg
         sivN2ABnXxVZHrSUfyNqfdCcuW8xcUxjipZI9nKpGcwRypd/PybGndxYwUBEw5RcSe7/
         sfIgt4xs42eIk0XmoPpxZXoVYSifZjojcwcXZWGnJDySdu1MgXQYhHh70VkckyYd8ItS
         zcyw==
X-Gm-Message-State: AOAM530G9/7rY4uOdN6BRjsPgLD9GQ8zIsguwsYK3ZykifYGe3eygU2E
        zSYkazMMnju+FyLhAi3SRTns27B/exv2cr1EMPb7wg==
X-Google-Smtp-Source: ABdhPJytUOFxylJO9GQfWCZxkgmC08Bcn5+HCLBHOxR+Vvj6poU2sA/tL72vkNkKpaNCAmBDljbV4s4UOoZM8sJO7UI=
X-Received: by 2002:a1c:7906:: with SMTP id l6mr2247505wme.22.1611620051415;
 Mon, 25 Jan 2021 16:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20210120202337.1481402-1-surenb@google.com> <20210125131935.GI827@dhcp22.suse.cz>
In-Reply-To: <20210125131935.GI827@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 25 Jan 2021 16:14:00 -0800
Message-ID: <CAJuCfpGu_x4vxXejTUfD4Mjun=qJOsdoRs42gQhiv30EnED=nA@mail.gmail.com>
Subject: Re: [PATCH 1/1] process_madvise.2: Add process_madvise man page
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-man@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 25, 2021 at 5:19 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Wed 20-01-21 12:23:37, Suren Baghdasaryan wrote:
> [...]
> >     MADV_COLD (since Linux 5.4.1)
> >         Deactivate a given range of pages by moving them from active to
> >         inactive LRU list. This is done to accelerate the reclaim of these
> >         pages. The advice might be ignored for some pages in the range when it
> >         is not applicable.
>
> I do not think we want to talk about active/inactive LRU lists here.
> Wouldn't it be sufficient to say
> Deactive a given range of pages which will make them a more probable
> reclaim target should there be a memory pressure. This is a
> non-destructive operation.

That sounds better. Will update in the next version.

>
> Other than that, looks good to me from the content POV.
>
> Thanks!

Thanks for the review Michal!

> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

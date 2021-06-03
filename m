Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABD39AAC5
	for <lists+linux-api@lfdr.de>; Thu,  3 Jun 2021 21:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCTR6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Jun 2021 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCTR6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Jun 2021 15:17:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69826C06175F
        for <linux-api@vger.kernel.org>; Thu,  3 Jun 2021 12:15:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v8so10446322lft.8
        for <linux-api@vger.kernel.org>; Thu, 03 Jun 2021 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CRsT8crQOoq4KK7EHvJ7QQM+oKI52My1kzGYaLGrfI=;
        b=R8VDVRcPoGt4k3cTxV+3sOakxWxFIWv9QitfEwkiZuFc+TePCnjK5n4i0LW5CY7vBE
         13FlE07lfLUcNnJ843cb2LCV/zg8vLt0u8cwi/gVWfImNpe1FxwNQ+MJ/WaTmrDjfj+J
         vXkTFwqZubZn2FR3ewqOSGR+9hjtemq0rhKHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CRsT8crQOoq4KK7EHvJ7QQM+oKI52My1kzGYaLGrfI=;
        b=bHOYC0SNDDcoM+3QMA4N9tdrwCYTZ6mZJsIsbxmNVHKwTD/ZyJOjGnx/JTIKmWLuAO
         Gzv1A2Iwxmibs34bcbiH5KVG+eRLRhANaR3CmPwoJEDFGlni2hDhmJJ1Gntc5Of8dhEh
         wWv9FFpQ4cMTVs6pkkPQ5g8hJacK+j9wi8yPufpGzzAAqTGTmLI6TrAH7Bd/z1xEPWMR
         vUGgxJjNdnMYSIZZw63lTc9bUAiZr59WZXRRosEhISMOrAB6xry5kG7/M0eaXIXCEIGR
         rTNaTTvI/iTuDOzVKL91MttXPR8KSYqecSFPX7fQqGcEEwu6KwWUwuyT8U+bTCE2bvy9
         f4Eg==
X-Gm-Message-State: AOAM533GCj3RSTyIkFA8zNZsANr9BVIDBSWSN1srNv71t6p1JK8ybbC9
        NthMZJc+VU3o4O/+7KcDHfQ8xe6i3UEuQIO5
X-Google-Smtp-Source: ABdhPJwGB9Z5c309M3PTALRDiWEvXQ4SlkpjXT/jq1K6E07Fltkc6/WTkTsmTVn1BAW/bXZmX7UYNg==
X-Received: by 2002:a05:6512:2390:: with SMTP id c16mr278088lfv.183.1622747756561;
        Thu, 03 Jun 2021 12:15:56 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id i10sm395073lfc.206.2021.06.03.12.15.55
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:15:56 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id w15so8471835ljo.10
        for <linux-api@vger.kernel.org>; Thu, 03 Jun 2021 12:15:55 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr626097lja.48.1622747755672;
 Thu, 03 Jun 2021 12:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
 <1622589753-9206-3-git-send-email-mlin@kernel.org> <alpine.LSU.2.11.2106011913590.3353@eggly.anvils>
 <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org> <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
 <CAHk-=wiHJ2GF503wnhCC4jsaSWNyq5=NqOy7jpF_v_t82AY0UA@mail.gmail.com>
 <alpine.LSU.2.11.2106031142250.11088@eggly.anvils> <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
In-Reply-To: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Jun 2021 12:15:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_r837DdEepGAA+jCz27Oqc5hxgYEJo9OoWrnKRhfz5g@mail.gmail.com>
Message-ID: <CAHk-=wg_r837DdEepGAA+jCz27Oqc5hxgYEJo9OoWrnKRhfz5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
To:     Hugh Dickins <hughd@google.com>
Cc:     Ming Lin <mlin@kernel.org>, Simon Ser <contact@emersion.fr>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 3, 2021 at 12:12 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, if that's sufficient, then that original patch should just work as-is.

To clarify: it obviously needs the VM_xyz flags things, but the
VM_SHARED check in do_anonymous_page() is fine, and the whole issue
with VM_MAYWRITE is entirely moot.

MAP_PRIVATE works fine with zero pages even when writable - they get
COW'ed properly, of course.

               Linus

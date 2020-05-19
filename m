Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB341D9E4B
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgESR4L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESR4K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 13:56:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F2C08C5C0
        for <linux-api@vger.kernel.org>; Tue, 19 May 2020 10:56:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n11so176877pgl.9
        for <linux-api@vger.kernel.org>; Tue, 19 May 2020 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bvPQ8PG+BL5wX2TZOP1m7rPVaLoET/IH7Hd3kojoQ1E=;
        b=Hky+N80HoOFgfGKHD5Eup/gUyJFTK88WweMFonjdT9tSUPmNG72SgnOZF3mV6VetX+
         kpJJGqHfyMQcwxAGOa3cXhLR1cEB0br0jZFXk0GhvwW+yBElVfXnEvEV4ogPkfSMFY1L
         YXu3Xu0EQhc4J3CHqb2xuMenLGSQGnocx3VdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bvPQ8PG+BL5wX2TZOP1m7rPVaLoET/IH7Hd3kojoQ1E=;
        b=FNLcLJrJYe9ZyhAcvWbJILyF68U0MN2i5RnE1ZnD0j6ADwEzmULTBHzC+Ash31uxB2
         jERgPJiBuV8wIZCs2YC4MAKr5exu8cBvjwGr5e/qwnTNo6qoby7NEQotux7qweZFPrgC
         JKfyycWc7dGzX+udUnoRIiATWmiLNin2pm1QD2URe5eMhK+xPbkf92wFbuQzA8OtjkRz
         qmvGwDUB9OKsoUveDOnjue5B5e/FLuOuf5OPOuifN1o0peQYB5M0VHJ6NAzAVzaoLkgt
         Dbvs2rju5y/v7mY/hcdTvdtplwZd/Zg8aollhvreUtpMv9n/x48DMvjz/ymh6JW7k7/j
         Frlg==
X-Gm-Message-State: AOAM533UiJuxvPXF3WC6o6NpOYUx9Oqkk98eghPhxw/KwMCoI1oRmlKR
        5qIgC3hBjGkrrZuluSrYkN9DLQ==
X-Google-Smtp-Source: ABdhPJw8wB1OuO4CBC5eeyAgZiGGsmQzCblUtTfTF7mycU6U4/dgYRE0e9vM9WK6gUSzh8ALn6RwzQ==
X-Received: by 2002:a05:6a00:d2:: with SMTP id e18mr288632pfj.252.1589910970277;
        Tue, 19 May 2020 10:56:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x132sm113693pfd.214.2020.05.19.10.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 10:56:09 -0700 (PDT)
Date:   Tue, 19 May 2020 10:56:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Relocate execve() sanity checks
Message-ID: <202005191052.0A6B1D5843@keescook>
References: <20200518055457.12302-1-keescook@chromium.org>
 <87a724t153.fsf@x220.int.ebiederm.org>
 <202005190918.D2BD83F7C@keescook>
 <87o8qjstyw.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8qjstyw.fsf@x220.int.ebiederm.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 19, 2020 at 12:41:27PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > and given the LSM hooks, I think the noexec check is too late as well.
> > (This is especially true for the coming O_MAYEXEC series, which will
> > absolutely need those tests earlier as well[1] -- the permission checking
> > is then in the correct place: during open, not exec.) I think the only
> > question is about leaving the redundant checks in fs/exec.c, which I
> > think are a cheap way to retain a sense of robustness.
> 
> The trouble is when someone passes through changes one of the permission
> checks for whatever reason (misses that they are duplicated in another
> location) and things then fail in some very unexpected way.

Do you think this series should drop the "late" checks in fs/exec.c?
Honestly, the largest motivation for me to move the checks earlier as
I've done is so that other things besides execve() can use FMODE_EXEC
during open() and receive the same sanity-checking as execve() (i.e the
O_MAYEXEC series -- the details are still under discussion but this
cleanup will be needed regardless).

-- 
Kees Cook

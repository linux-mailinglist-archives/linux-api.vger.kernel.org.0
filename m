Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4004DDFBC
	for <lists+linux-api@lfdr.de>; Fri, 18 Mar 2022 18:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiCRRWI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 18 Mar 2022 13:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiCRRWH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 Mar 2022 13:22:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A42A2DF3FF
        for <linux-api@vger.kernel.org>; Fri, 18 Mar 2022 10:20:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so2768895pjq.2
        for <linux-api@vger.kernel.org>; Fri, 18 Mar 2022 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wI8RFHnMZ/ord/RFlr63IZcZowLUZNUmIF9gHirMLqk=;
        b=krmhetMSHSN+BhgLY4DNV1HbVv0fwryryHNFyHRc3Zd2xEn0QEi7bS97QQNjCp4VST
         KQX96x29cdCNw3OHSvE8aOkTlm7mOmlud6/5pjV8KdXSS7qfYehWUvKWHLr+1gQ9w1t7
         PhH1Eb1gRgVgvgeDHo0dIZesx8U1zBVS1YEcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wI8RFHnMZ/ord/RFlr63IZcZowLUZNUmIF9gHirMLqk=;
        b=ZFJ8phkgnf81tHaV4/rul+yD0miaQh4wukP0Cu0IHx/90Mr0oiYFpTEmuAVqvSgZlz
         xA4sNYZD1HAltJAjRzCCQVrpQeMSlPzZmZRd+EblT+sSudbUDLLpphlRHKijhj3NVmUJ
         aXxRjdQRLtbrG7rHXvIm4fVoTCTYWzcgFGkb37TTD2rHAogHoa+g7MVOqkU758aeGmAU
         geO+fx1aFGor3YS2Hx4Tz0DFdF1aEjgfIgJOV7ZGxOoEfLxEZHlc6UFCAh/mrcnPdRpC
         qnpZF5ZCHU4JPRtyFp5vmti8ZcCyEo6Z9qgMoJeo3I998zMrTYeMJtubhp9xAa1nQzGJ
         r1+Q==
X-Gm-Message-State: AOAM531UWXd4FRkdjRcgF7DKm2fNYChXwkHI/qff10ZAQHp96jmUv7PC
        H+h2+uMqlj1QQ3AeHMENmoAXlw==
X-Google-Smtp-Source: ABdhPJzSQb+APMshfGD9QDYJDR1zXQnnjMDlvX76HFd4hafq269zaDls7rytBGplARDSLpfnGdNJFg==
X-Received: by 2002:a17:90a:e397:b0:1c6:3b63:bcbe with SMTP id b23-20020a17090ae39700b001c63b63bcbemr12105144pjz.180.1647624047726;
        Fri, 18 Mar 2022 10:20:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3-20020a63ae03000000b003820cc3a451sm4220567pgf.45.2022.03.18.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 10:20:47 -0700 (PDT)
Date:   Fri, 18 Mar 2022 10:20:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] ptrace: Move setting/clearing ptrace_message into
 ptrace_stop
Message-ID: <202203181019.434DA4186@keescook>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
 <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <87bky67qfv.fsf_-_@email.froward.int.ebiederm.org>
 <202203171209.FC87C7B08@keescook>
 <87fsnf2ucx.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsnf2ucx.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 18, 2022 at 09:44:30AM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Tue, Mar 15, 2022 at 06:21:08PM -0500, Eric W. Biederman wrote:
> >> 
> >> Today ptrace_message is easy to overlook as it not a core part of
> >> ptrace_stop.  It has been overlooked so much that there are places
> >> that set ptrace_message and don't clear it, and places that never set
> >> it.  So if you get an unlucky sequence of events the ptracer may be
> >> able to read a ptrace_message that does not apply to the current
> >> ptrace stop.
> >> 
> >> Move setting of ptrace_message into ptrace_stop so that it always gets
> >> set before the stop, and always gets cleared after the stop.  This
> >> prevents non-sense from being reported to userspace and makes
> >> ptrace_message more visible in the ptrace helper functions so that
> >> kernel developers can see it.
> >> 
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > This looks good to me. Did you happen to run the seccomp selftests
> > before/after these changes?
> 
> I did not.  This is a pure ptrace change.  Do you see a way that seccomp
> could be involved?

Sorry, that wasn't clear: seccomp includes a number of ptrace tests as
well, especially involving handling process death, messages, and
signals. I'll give it a spin; so far it seems fine.

-- 
Kees Cook

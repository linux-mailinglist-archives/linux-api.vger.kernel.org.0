Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425604DCE79
	for <lists+linux-api@lfdr.de>; Thu, 17 Mar 2022 20:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiCQTLg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Mar 2022 15:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbiCQTLf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 Mar 2022 15:11:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EEF208C2F
        for <linux-api@vger.kernel.org>; Thu, 17 Mar 2022 12:10:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so6310987pjl.4
        for <linux-api@vger.kernel.org>; Thu, 17 Mar 2022 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q+Yvk4Xw+jpjX5xTLCBpPZo0AleetlGgSVjMzYWsGsY=;
        b=PtsRNGgXT9KGmeoGD0ZfYSh4rI+8giEJ2KDLATss1DA+b5E2XmtOoQvuZ7lR5RaKJg
         JNeCtFapCZfcql3cKxFdtTHYu4iLSgQo7W4B3/5Tw6krOSf6xcBxeDdC8M0yIA0vu+Rq
         yj5wV7ukcYSwWBq5UxpsKMXGM1CWepdL1z5+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q+Yvk4Xw+jpjX5xTLCBpPZo0AleetlGgSVjMzYWsGsY=;
        b=6rzIzY4RK82KRfgBMVuZA5ZkxSC3llkqb3boHbofaixrKhAjjMtz6ZWqnDXcTLVmEk
         Y6l4wfh8S1MVPMGsUJjdl07r+JUZlET+8iZNyW0q82k7yf0m6k95qNfrR1mD+84ELuiE
         SszdhBczJISlG9Xwyd6bGrhCWJ++L0t1Un9DkriXmcItYkp+/N6HfV++Gx6bh+ETcmA8
         1hsGeyG2Qqoqfv1S5vmYN4QtCfq4zEFK6R6JbdPE/4IjgDjKr4f7DE7NkOXB8hlVWV8q
         yOJnPcmW8uad309axoljj0nUphVDOBtT+SHynFIyS2NeT28FibO/M1qV14ozYOfAT13T
         Omdw==
X-Gm-Message-State: AOAM5305Sx+7uW6W6J3/r33KwwvrHbypJgaM2H6tfUjBL27NVviuAeH9
        BGETwPmJpjoEnzxApV9TpFQT8A==
X-Google-Smtp-Source: ABdhPJzLSAJmtCqtOTC+5DBrXu+wjHpu7EwHOXE/Ox6qNc24/dd5OCcG8i8AC/ClqpXCGpifd8BQGg==
X-Received: by 2002:a17:90a:f2cd:b0:1c6:5a37:69ab with SMTP id gt13-20020a17090af2cd00b001c65a3769abmr7123263pjb.224.1647544217875;
        Thu, 17 Mar 2022 12:10:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h11-20020a056a00170b00b004f7a83058d5sm8094040pfc.16.2022.03.17.12.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 12:10:17 -0700 (PDT)
Date:   Thu, 17 Mar 2022 12:10:16 -0700
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
Message-ID: <202203171209.FC87C7B08@keescook>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
 <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <87bky67qfv.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bky67qfv.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 15, 2022 at 06:21:08PM -0500, Eric W. Biederman wrote:
> 
> Today ptrace_message is easy to overlook as it not a core part of
> ptrace_stop.  It has been overlooked so much that there are places
> that set ptrace_message and don't clear it, and places that never set
> it.  So if you get an unlucky sequence of events the ptracer may be
> able to read a ptrace_message that does not apply to the current
> ptrace stop.
> 
> Move setting of ptrace_message into ptrace_stop so that it always gets
> set before the stop, and always gets cleared after the stop.  This
> prevents non-sense from being reported to userspace and makes
> ptrace_message more visible in the ptrace helper functions so that
> kernel developers can see it.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

This looks good to me. Did you happen to run the seccomp selftests
before/after these changes?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

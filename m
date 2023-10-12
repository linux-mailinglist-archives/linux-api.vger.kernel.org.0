Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7D7C793D
	for <lists+linux-api@lfdr.de>; Fri, 13 Oct 2023 00:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442988AbjJLWHh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Oct 2023 18:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442981AbjJLWHh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Oct 2023 18:07:37 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD37C9
        for <linux-api@vger.kernel.org>; Thu, 12 Oct 2023 15:07:35 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso1016330276.0
        for <linux-api@vger.kernel.org>; Thu, 12 Oct 2023 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697148454; x=1697753254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTpO+n7M6TPusV7FMWLowRWDIaW45wTQ8zFKVmNzMBQ=;
        b=NW5Z3rCCFc2KtasrXAoE9YL/QIbz1vQDdiY4kWi7QG288MJng1pggtfP7I53rMHK3T
         mP81r4KgN/sGKrM+Ikg4GVcyp8eaoPEnzdYGYsiK8IXDbVVDOjAuHTH21ZydwMB1G+H6
         mebPzSmpNXRGlGxQVAxOWR/r+Fnl+JOntj/ywwxGQlROtlt0I07mx4Qq7zOIsh1yJlG8
         9ao49TZY3RhFBZXBC3bpnW6EyoV4Gij0uQj4mEuhEhPERc5F3PfJyWcVNUGCaI3b+kYh
         qPohKsNLmCbaycIlcTfj595HnFr98uhXUPVkKhTK327msSyq2iutmiYaA1NgYgjbTGos
         iv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697148454; x=1697753254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTpO+n7M6TPusV7FMWLowRWDIaW45wTQ8zFKVmNzMBQ=;
        b=VsqCclLDwkM8z4dpxGzAbSd5ypNeTUDAf2CsM8yU2hIvPbi8yjDpIKsNtMvMa+dJxJ
         L9rU0YKHkPdIrFCWVKcQWer4RuzWktZZ3+AoNcBVFJiMH+T1QpGO7Eb2dWCHjIwRgUyx
         ySW5XjeSz0PFdeYdYyfd34R7FsERd4O7cnPEomPGoSMhRom9GMbxcF88ngPWmSq7TAna
         N1BXJ2MgWa0xA5ADqWGlWEDyg/XrNT5fCjgBjfsC+utGyVaTNYC7V3xZB/VYfGP2Wmz8
         DoVn4JinMQU++PLejwIRExvIbYeWMK+k9M6u7d4MeiU0ZwD/PNHHzaMZrUg+XYazF1m3
         sHjw==
X-Gm-Message-State: AOJu0Yxb67vqo5pZ2MAcn/4IkK9RrttIC+j4J5HR+uEMWgeSgTDVtih2
        M3F8kevugp3Ojwzuc+R7cV7B0pNwymR2wp1drutJaj/Pasi/tSs=
X-Google-Smtp-Source: AGHT+IFCCAqMHcCOC2zCF8+Q5T8WEXUqQeKxVVUJ5FXWykxKz087i2mYibghbz7BJCKnZoqSGweTZQ6cBwPP1Hi4V30=
X-Received: by 2002:a25:ace0:0:b0:d9a:decd:ed3a with SMTP id
 x32-20020a25ace0000000b00d9adecded3amr1493296ybd.26.1697148454517; Thu, 12
 Oct 2023 15:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com> <20230912205658.3432-1-casey@schaufler-ca.com>
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Oct 2023 18:07:23 -0400
Message-ID: <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 12, 2023 at 4:57=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Add three system calls for the Linux Security Module ABI ...

First off, a big thank you to Casey who took it upon himself to turn
my pseudo-code syscall suggestion into a proper patchset and saw it
through 15 revisions.  Thanks also go out to everyone that has helped
review and comment on this effort; I know everyone is busy, but these
reviews are important.

I'm happy to say that I think we're in a good place with this revision
of the LSM syscall patchset.  I only see two outstanding issues, and
neither of those are bugs/showstoppers that affect the API, they are
simply areas where the implementation could be improved.  With the
understanding that Casey is busy for the rest of the month, and my
desire to make sure this patchset gets a full dev cycle in linux-next,
I'm going to suggest merging this into the lsm/next-queue branch soon
(likely tomorrow) in preparation for merging it into lsm/next once the
upcoming merge window closes.  Those who want to help improve the
implementation, as suggested in the feedback on this revision or
otherwise, are welcome to submit patches against the lsm/next-queue
branch and I will merge them into that branch once they pass review.

If I don't hear any objections I'll plan on merging this patchset
tomorrow, I'll send a follow-up reply to this email when it's done.

--=20
paul-moore.com

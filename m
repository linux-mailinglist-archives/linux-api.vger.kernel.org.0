Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71FABD39A
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2019 22:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436839AbfIXUbZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Sep 2019 16:31:25 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45432 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404628AbfIXUbY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Sep 2019 16:31:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so2862526oib.12
        for <linux-api@vger.kernel.org>; Tue, 24 Sep 2019 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gnH1hIumhjs1U65zhqlbJaNofnYNZHTIm6gh8mVIcKU=;
        b=hGoESwSUjxVfPEzR+jVxVH90xU0VZFNySAY+QJr5Ig7OAEMxPiAhSXT0T5BVxUmAON
         VeaFnceD+Y/2frLM2/SFPSS80AfXO3O2CqmUUKXKLeUurtYf7ndNfA3zU2UpsaJVFyPo
         tprbtU/jvGMX+1vWgsJRahVfj6VrP51gYcXGbyCHpHI4qkIFkxHULr/BbaJ5ej1FKdAy
         DQRIc3RPA5rzPl+p49+FX4vqtsuuw3f3qZ3u+WfAzgJlG8DVL8SfewF48oKDKpEbdUxg
         pkoaPhcDUFMLh2oY7vayI6feQ9fDc9r+hkRU4u7hZIfnRfYypAxa5W5SR+o+S/ARfowd
         3Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gnH1hIumhjs1U65zhqlbJaNofnYNZHTIm6gh8mVIcKU=;
        b=ktkHclqDOJg++AKUeR2dkDIWv2bxDPEAb/iOjJ0ZF/GHEzzsARxLDlyUpfmmuvKut8
         FwJRhnnWA6hKuURJRXBwHxt4L/wM1Oj3/s43FSjLkNZXRUCRwSLju93Rmpnxb5Iox6hU
         YLaLj4iuiEM+IsZ7HEjpwT4tkPcXMNfsLlClKwZmf26KOrfRUh+urTOhj6y7LLCKVWOA
         kAhM9NdCzThm0W/OksFa4gO6TmYDi5FtzCA/pMqrqcUF65EJahyYiQ4zhA3Ap7U7p8nf
         WAWp87o4lePdRr4j0VJQ2/GpYtWaQ8lP8F0qhiZuvs5OKyFg5Gv5xzMJp7bg5rlKY5uJ
         PMVQ==
X-Gm-Message-State: APjAAAXs7D1Hkw4gHxl9j2wJ/rFATC2n4sSsuEWFb+wqOtDtERvDbt/j
        0UKFhkzlLoON4mFVymHMXHNFx53L0MbLqWWfW0C8TA==
X-Google-Smtp-Source: APXvYqxniVpvMNA+bj/yUEKpmVq/ao8OQjFhfGsHKuXQQKykILeLG60EsYREEBp+78hGREeG2Q58F/qZGtcpArkKizM=
X-Received: by 2002:aca:b506:: with SMTP id e6mr1794758oif.39.1569357081429;
 Tue, 24 Sep 2019 13:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568990048.git.luto@kernel.org> <66b16acf2953fc033abc9641b9cf43d23e75a8e9.1568990048.git.luto@kernel.org>
In-Reply-To: <66b16acf2953fc033abc9641b9cf43d23e75a8e9.1568990048.git.luto@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 24 Sep 2019 22:30:55 +0200
Message-ID: <CAG48ez2tnJzLNCgAqCC+AOKuLGBSvBRi2_HZ97bEJ0zP1kWLHg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] random: Remove kernel.random.read_wakeup_threshold
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Theodore Tso <tytso@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 20, 2019 at 4:37 PM Andy Lutomirski <luto@kernel.org> wrote:
> It has no effect any more, so remove it.  We can revert this if
> there is some user code that expects to be able to set this sysctl.
>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/char/random.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
[...]
> -       {
> -               .procname       = "read_wakeup_threshold",

There's a line in bin_random_table in kernel/sysctl_binary.c that
refers to this sysctl, that should probably also be deleted?

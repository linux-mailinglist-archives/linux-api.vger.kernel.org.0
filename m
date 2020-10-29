Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6669A29E02A
	for <lists+linux-api@lfdr.de>; Thu, 29 Oct 2020 02:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbgJ2BIv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Oct 2020 21:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbgJ2BGK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Oct 2020 21:06:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFCAC0613CF
        for <linux-api@vger.kernel.org>; Wed, 28 Oct 2020 18:06:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x16so1310594ljh.2
        for <linux-api@vger.kernel.org>; Wed, 28 Oct 2020 18:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GGrU2z1MQIER/cvvO+UmfkeQMG5BianEcYdHiHe9qyQ=;
        b=Ug/McNP55t1xm6mf6Z65dD0d/4XLutY+oae+4KAHg9dQk7Ug4H28uN0ZtA6M7NgpbT
         I76xZ2T09J5d7Ybn9ysY9RjSdQylACxpwnNQDr/Whe2xhZiOlFqCT3OIsA9q6zLzDeCR
         81KtjKOTYR80DEEdXwrEXNgjq/YrpBGqKd9yqxwWPNsE3aR79VfrgmiIiCuvt0LOqp4p
         g9SdQ3WjkMfuDJcu5J+Ntpja9H+lqlKUJo2zM/NDZEiWEQKPOjO10MeAjoZ8CaD+3oKL
         C211FUrW1ORwXJZC8XlCmBgNTqf5GZzQLzPlE4Pp9aFCrQeZrd63oWztHdhVhAjJQL1T
         dF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GGrU2z1MQIER/cvvO+UmfkeQMG5BianEcYdHiHe9qyQ=;
        b=ZDgxXgaCrFfDvBDPsS/+H6zr201Y9ikjyrN/+obACiy08kEaIX2HQfT7chf5Cjgts2
         ADvtf57AsE6FCkveCLKpDoqSYfAfGyftLxqEz0rQxV6QJ2mOK5/BXdpJptOu6bMU5dOy
         qf7oD2HDd7lECjtQMJA9viOtp+MoSy7TVJFCvvWLA3SGvV9rUl1RYUDA/EFYIYf/RgX2
         46R76xa9TTq/prYntPRoAF1Nu8Xb4djbuljh6Z7K24M87p/wuEvstwfttXxZNEMdTh7D
         9Iez8ZNLUM9VQhuX3rGzTU5g0hdptZycNZ9KY4uWzaiMiUbfs8KLfWhUlJLnc2tuI1Zi
         FrwQ==
X-Gm-Message-State: AOAM532r52Zlyil5B/RPsl0YsvdK2P0TTacXBFtz595Z+J680ws4rdbH
        DbusIcZOHbCVqpcYPeEdVQTNGj1h5XQ20Meqhab4SQ==
X-Google-Smtp-Source: ABdhPJwED9L0K+8kxvJCn6lQw5MHjDYLpGe4e16Gh7aY6DgACpmCDb7qbKA88fIn4deadsqcNqBfZ2vFqTocP7vkRyk=
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr725677ljk.160.1603933566252;
 Wed, 28 Oct 2020 18:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200358.557003-1-mic@digikod.net>
In-Reply-To: <20201027200358.557003-1-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 29 Oct 2020 02:05:39 +0100
Message-ID: <CAG48ez31oct9c8fkgFHQVb5u-o5cmwdNe2pJnmitnKcidNgfzw@mail.gmail.com>
Subject: Re: [PATCH v22 00/12] Landlock LSM
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 27, 2020 at 9:04 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> This new patch series improves documentation, cleans up comments,
> renames ARCH_EPHEMERAL_STATES to ARCH_EPHEMERAL_INODES and removes
> LANDLOCK_ACCESS_FS_CHROOT.

Thanks for continuing to work on this! This is going to be really
valuable for sandboxing.

I hadn't looked at this series for a while; but I've now read through
it, and I don't see any major problems left. :) That said, there still
are a couple small things...

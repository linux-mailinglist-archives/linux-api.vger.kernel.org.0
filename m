Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7A66D533C
	for <lists+linux-api@lfdr.de>; Sun, 13 Oct 2019 01:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfJLXND (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 19:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfJLXNC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 12 Oct 2019 19:13:02 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E1621929
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570921982;
        bh=+wHs2Y/Qg5mogbSpED8FXiNC/fGFHyhQ+Ml3FmkKkSo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WwC2Zd/EElIEXkBTdXusEwwsN4TJ4e5D5MZxTtfywIxcnPXQrwGl5L6KJELMbxZCM
         S2pRWM8koBpwKPoErCqpDh/JoZER3vtzcv1N90m4xpbH+WN/fw1KTsMGpT5lRl4XwD
         HHBuNFJU67xnwaOi7vgnJujwYccyolwUM8aW4WPE=
Received: by mail-wr1-f46.google.com with SMTP id n14so15528722wrw.9
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 16:13:02 -0700 (PDT)
X-Gm-Message-State: APjAAAUUJ5A2WPKog5NHXt+JIxma9qVsJ+cKyfNQWdiaYYSWTplyyDAH
        FHpj6n5qtAIP3DRMtWB4/n8bbyiPhk1FW8Nte3a1rA==
X-Google-Smtp-Source: APXvYqw7HEa5GYoH47kjNp12sTWsxaiCKc6Zk/2lzuijVQxR+tnPNkLDBsht+XtGjda/KjufIv6NxSXSW8gqONbWoYA=
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr20086297wrr.61.1570921980646;
 Sat, 12 Oct 2019 16:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-7-dancol@google.com>
In-Reply-To: <20191012191602.45649-7-dancol@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 12 Oct 2019 16:12:49 -0700
X-Gmail-Original-Message-ID: <CALCETrWF61dmSpMEYvqa2FHWL8Zj6GJtevFTfymV20CCjiqRcg@mail.gmail.com>
Message-ID: <CALCETrWF61dmSpMEYvqa2FHWL8Zj6GJtevFTfymV20CCjiqRcg@mail.gmail.com>
Subject: Re: [PATCH 6/7] Allow users to require UFFD_SECURE
To:     Daniel Colascione <dancol@google.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lokeshgidra@google.com,
        Nick Kralevich <nnk@google.com>, nosh@google.com,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
>
> This change adds 2 as an allowable value for
> unprivileged_userfaultfd. (Previously, this sysctl could be either 0
> or 1.) When unprivileged_userfaultfd is 2, users with CAP_SYS_PTRACE
> may create userfaultfd with or without UFFD_SECURE, but users without
> CAP_SYS_PTRACE must pass UFFD_SECURE to userfaultfd in order for the
> system call to succeed, effectively forcing them to opt into
> additional security checks.

This patch can go away entirely if you make UFFD_SECURE automatic.

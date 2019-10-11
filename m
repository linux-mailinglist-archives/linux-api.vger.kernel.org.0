Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3EED3665
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 02:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfJKAkw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 20:40:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41853 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfJKAku (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 20:40:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so8047893ljg.8
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2FS1xOZd/52wDxpWUrAmpLbVkhqrk6X7y4KWQdphOQ=;
        b=excfJ/xPWZ2+jilbteJY4Vi+c9HHFbmh8FkB0VkVQqsRNzfaN29He3nWLonU+RXfhK
         3pXMA0TLVwHppNQr0AUdUG53U42HF+9GxxpGlj/4kcIRtN2pAGAhjypJkZNwf6iE4U2K
         QnDU6KwbkTBSAhWjCsQuxo6Yvo3mAnUXyeDgSEkA6Cy+jFD7qJ0JXa3ufc+Z8Ubil/UN
         0Cdjgen9Fv8pItZNyHwfvmTyOXAjZeb7m1pS8EB6mZ+mIjfO5jq4nE77VYMmJNXOtxB7
         kvPLp8grvYwauQ5k1eqQDdg2eooaCdMYqVLWUpqPOHk/o0cD7moYJjQphs+tsLLeny72
         W+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2FS1xOZd/52wDxpWUrAmpLbVkhqrk6X7y4KWQdphOQ=;
        b=NR71Meap9smm1UDnjd+LMbEs1fpVwBlot+Zs9EbxAoEpUxEfUMMkviAZKGGfmFZptH
         WTkV7XYGliTaQlWVM6Dy0P/kU5EPfFjhf6kx4wCuP4rkL9RRsxhrXvaaN+ZGm2TbrbAB
         chDcAVONO0AqdNqLdJUyKrd7/FjFJftH5Zqhj8JV2r61IUXWPuuRihZ4phB7U23YboA2
         KgRXrU88/N0bMXAozNYpkV/GKOxlcKKBTYgIdNyndkbMbVx8kFDjNEizWI/fstji1S7V
         barR1AumF1WyDzF7qfKNQb6vjrCXPj72ipCgeobHCotf7nTzJDi887dcM/eftK9/hxtq
         F58w==
X-Gm-Message-State: APjAAAUHb5GbGVdFmaj/8WrmwU/E9YsEYsxz3o5FFz4Jck+I9isecUil
        giXaVckEAaD18sB4jfqRDpkscs73sPuWTfcwTdmk
X-Google-Smtp-Source: APXvYqxJgQInWarY5/M7kUO7HpwvMg1Nlpj/lgKKRdJtv+USUKJpyXPsrOQoku+hafT+CZ2zq5wB40bIA3VRiBrUbu8=
X-Received: by 2002:a2e:8ec2:: with SMTP id e2mr7129095ljl.126.1570754447449;
 Thu, 10 Oct 2019 17:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <ea4e8352fd1671f91d1b015a15abee785ea17136.1568834525.git.rgb@redhat.com>
In-Reply-To: <ea4e8352fd1671f91d1b015a15abee785ea17136.1568834525.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Oct 2019 20:40:36 -0400
Message-ID: <CAHC9VhRUmHiuRH6xYZo36hoV34ouNv4Ny0sWZYcz2dnEhx9nsA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 16/21] audit: add support for contid set/get by netlink
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 18, 2019 at 9:26 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Add the ability to get and set the audit container identifier using an
> audit netlink message using message types AUDIT_SET_CONTID 1023 and
> AUDIT_GET_CONTID 1022 in addition to using the proc filesystem.  The
> message format includes the data structure:
>
> struct audit_contid_status {
>        pid_t   pid;
>        u64     id;
> };
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/uapi/linux/audit.h |  2 ++
>  kernel/audit.c             | 40 ++++++++++++++++++++++++++++++++++++++++
>  kernel/audit.h             |  5 +++++
>  3 files changed, 47 insertions(+)

I'm not a fan of having multiple interfaces to do one thing if it can
be avoided.  Presumably the argument for the netlink API is the
container folks don't want to have to mount /proc inside containers
which are going to host nested orchestrators?  Can you reasonably run
a fully fledged orchestrator without a valid /proc?

--
paul moore
www.paul-moore.com

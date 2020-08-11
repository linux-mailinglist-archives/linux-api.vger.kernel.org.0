Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA5724216D
	for <lists+linux-api@lfdr.de>; Tue, 11 Aug 2020 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgHKU4a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Aug 2020 16:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgHKU4a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Aug 2020 16:56:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28ABC061787
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 13:56:29 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bs17so10135674edb.1
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIwwgXuVYR9J8FN3Q7OBMSeO2MRyPkPN2N5o9h2ay8w=;
        b=eKcrw8bQXY0ON3Tby3NTqixV/DjoLpozBmhQ9Wxh8CrzQKneLuoqFBgMjT6gAHEG5x
         zYyv+zLUzEwpSrr4OU+QfyjH1a/L/3382mM+GuZnpa9mC47RvCYGIpTbFcfYEHdSy8L3
         lYq0C+Xov6wYQlMCdmDB+OTEIdrvHwkv9okCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIwwgXuVYR9J8FN3Q7OBMSeO2MRyPkPN2N5o9h2ay8w=;
        b=a5CDW0bW978bIXIhVYxWdRAuaHJFB3oa95T/CYBymWi95+BHRpzpTBiKJIcIfPjV/s
         dF/qYa8CBtknPbi7a0tdinVScVTdQO8kAokLeaeMagu9cL6fOXP8Xqb3GU8la3HSrH2y
         j4cH7Z1RHr6IDgBpiPQ4sgEBqeD6aJ6oIp3QbzaPgXKe/j4z1DViZwAtin6nDTJinw4x
         uMhtxnhudR13Z1W8t+sRIp2eezRGeeyMG6bc7kHCeiBqT5FhJyaN1bLGeA78Dd43eC8z
         IrGu4MsZJPyxKyu6rJBec7wSc0qaEUNlaEt0WWoWNQzHfz0CeQry/DJpp9zFAau2ZByw
         opSA==
X-Gm-Message-State: AOAM530V+hlw7I2ktUb27b7ZLEM2o97AESHafFm6ngF8UBmOAGNjMYoo
        l7sjYzH2DCywx5NhIAE8l7C9PdfXyWRtE+Yq52Oh6g==
X-Google-Smtp-Source: ABdhPJy0K+Fs+OPN9rfm6Efrlr92XTN+ignCX68MAQVFzGb3drIK9V+44cU7wIUR+/6aonnP7KkpSeyJKYyxyPce3Ms=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr27523537edx.358.1597179388290;
 Tue, 11 Aug 2020 13:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com> <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
In-Reply-To: <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 22:56:17 +0200
Message-ID: <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Jann Horn <jannh@google.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 11, 2020 at 10:37 PM Jann Horn <jannh@google.com> wrote:
> If you change the semantics of path strings, you'd have to be
> confident that the new semantics fit nicely with all the path
> validation routines that exist scattered across userspace, and don't
> expose new interfaces through file server software and setuid binaries
> and so on.

So that's where O_ALT comes in.   If the application is consenting,
then that should prevent exploits.   Or?

Thanks,
Miklos

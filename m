Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8EF2421D2
	for <lists+linux-api@lfdr.de>; Tue, 11 Aug 2020 23:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHKVTB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Aug 2020 17:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVTB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Aug 2020 17:19:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A399C06174A
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 14:19:01 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so15145035ljd.0
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 14:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rA8YRs7dGB/GfkhZuYULS9uPbpqUgOSLUWngUo8yoaM=;
        b=B37Vu6gJyZiMc+9rfRlkcU20N9U10pvTExHnPuibbYthtQqVMegykJE7HYcY2zldNY
         5gxGBXFItNBRH8z/eG/knEXfMsho/PZusS91v/AIuz6EknTOjHM1WbX1WJwE9Kjez0Pq
         BW2ud3bdkqnIsddUMftapP9Lsi2ETAl3njB+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rA8YRs7dGB/GfkhZuYULS9uPbpqUgOSLUWngUo8yoaM=;
        b=hvRdVn3tb5WoJVTwELyBst9ZB7JKNNDoIHx7C+GpAOmOXwqBmTtOKJASBHxKKAwl6E
         +LN9fB1F3bxCiBeWlUYI56ED3fiyprxYNVFp1UIZ9lodvS5N5/HKtTw2bcEkLt5wAaPr
         dTuHr86pDPrx64AnXIFvverKoDKcCeWHaTyfB3Q81Igm4HhsLO/v2W8NUqD5gJd6BLoK
         gIEcDcnpezNn2nsz0dGRv5TR34XDGPCs7YwUjN5Bl3Zje/aOqS5CjGSGgdT7U77toDcn
         lWGpyrsy0/UJFE49/WYqsMDvdnmCdZHJIBWXyc43yNT247xZ6kOl6Zkq3E5PtKPXTbmo
         iMQA==
X-Gm-Message-State: AOAM531cBKbTbm02lXkJgu2pwhB4DDeUtuJk9cmFGDgHxOMrbyYC+fOO
        TRU+ZsmF4JQPZ73awruUXfDySMhIM/E=
X-Google-Smtp-Source: ABdhPJz7QqTC1F3Kw9DjfMy72p+lujv1qnY7/4Z8qaSzy5npi74oXiVIkpxAoFVcf/LZpFMmNL80MA==
X-Received: by 2002:a2e:a586:: with SMTP id m6mr4111087ljp.458.1597180739306;
        Tue, 11 Aug 2020 14:18:59 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u10sm11842953lfo.39.2020.08.11.14.18.58
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:18:58 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id f26so13723836ljc.8
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 14:18:58 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr3970905ljf.285.1597180737731;
 Tue, 11 Aug 2020 14:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com> <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
In-Reply-To: <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 14:18:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
Message-ID: <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
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

On Tue, Aug 11, 2020 at 1:56 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> So that's where O_ALT comes in.   If the application is consenting,
> then that should prevent exploits.   Or?

If the application is consenting AND GETS IT RIGHT it should prevent exploits.

But that's a big deal.

Why not just do it the way I suggested? Then you don't have any of these issues.

              Linus

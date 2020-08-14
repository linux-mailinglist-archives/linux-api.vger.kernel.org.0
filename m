Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F720244D44
	for <lists+linux-api@lfdr.de>; Fri, 14 Aug 2020 19:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgHNRFb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Aug 2020 13:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHNRFa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Aug 2020 13:05:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD061C061384
        for <linux-api@vger.kernel.org>; Fri, 14 Aug 2020 10:05:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so10660199ljc.10
        for <linux-api@vger.kernel.org>; Fri, 14 Aug 2020 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYuJ9NHHO+qnoSaHW0PlHI0fiXCW7zDlZFu/ah5uFho=;
        b=QZC+eNnnLcPaczh2E7Iym7nx2PQpiiDURT50bzxJZUsdtO86YlDCUBTiiWPJAXsWnA
         U49+U2ao8O1Ymle/LvRAFOmnKYrXWnRy0koTc1q4uPH3YiU1H0Bu0Wp5Fx58rMDOEorn
         lZP3mAReqkIBPzLDybNfptRtvd5sif7WdrmnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYuJ9NHHO+qnoSaHW0PlHI0fiXCW7zDlZFu/ah5uFho=;
        b=HCVrfyW79KCPKmqyuCuG8Wf6DnsWIEaXivLO9cHllUNk5fdzAR+mOAV1dxlDrNAQHd
         xlvLZmOOtJDRM0meFc6e4Yzp4x6cKB+V+kBHDUUR/ANPzjedVqbBdqpnOrUogWaGmFh1
         ycvjC/QrKKm/ac9m1tfqIEQrQYBVq0xxuzk7BsErsXf/QwnUqTSFUmZq/TYvNppYna+t
         bhRuj31kcZH37Ym5/zCieD+BmSpD+MDvPhCu0vMYAvdqaahzzhkXgwIHBssQAMYplhng
         ux+rUDoPgYemC1e/6EJBjld/Cl4gok0N/vu8PXWOifUxiIZmkEsj51h2ZHCUXtbwbzlF
         K7UQ==
X-Gm-Message-State: AOAM532CdKKxkPoAgpGB/J0NixfCB8TSaWHu/c8o+rewR8oGm/jLniOh
        cV0rlMhc86NXM8fxBpL8fCWQbrMymkCGEw==
X-Google-Smtp-Source: ABdhPJxoIvU0Q2hbO5GfRTvWY+LgpOOVAFbDNt4HQLL0UmE5DxTrVHNFQon8x7OVZPLC9R4ShIW4Qw==
X-Received: by 2002:a05:651c:221:: with SMTP id z1mr1628327ljn.52.1597424728132;
        Fri, 14 Aug 2020 10:05:28 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id j6sm1858983lja.23.2020.08.14.10.05.26
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 10:05:26 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id t6so10643791ljk.9
        for <linux-api@vger.kernel.org>; Fri, 14 Aug 2020 10:05:26 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr1629608lji.314.1597424726058;
 Fri, 14 Aug 2020 10:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <679456f1-5867-4017-b1d6-95197d2fa81b@auristor.com>
In-Reply-To: <679456f1-5867-4017-b1d6-95197d2fa81b@auristor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 10:05:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLhwum2E+qperD=TypGHXxoBtXOu-HHDd9L9_XFFyiaA@mail.gmail.com>
Message-ID: <CAHk-=whLhwum2E+qperD=TypGHXxoBtXOu-HHDd9L9_XFFyiaA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Jeffrey E Altman <jaltman@auristor.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
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

On Wed, Aug 12, 2020 at 8:53 PM Jeffrey E Altman <jaltman@auristor.com> wrote:
>
> For the AFS community, fsinfo offers a method of exposing some server
> and volume properties that are obtained via "path ioctls" in OpenAFS and
> AuriStorFS.  Some example of properties that might be exposed include
> answers to questions such as:

Note that several of the questions you ask aren't necessarily
mount-related at all.

Doing it by mount ends up being completely the wrong thing.

For example, at a minimum, these guys may well be per-directory (or
even possibly per-file):

>  * where is a mounted volume hosted? which fileservers, named by uuid
>  * what is the block size? 1K, 4K, ...
>  * are directories just-send-8, case-sensitive, case-preserving, or
>    case-insensitive?
>  * if not just-send-8, what character set is used?
>  * if Unicode, what normalization rules? etc.
>  * what volume security policy (authn, integ, priv) is assigned, if any?
>  * what is the replication policy, if any?
>  * what is the volume encryption policy, if any?

and trying to solve this with some kind of "mount info" is pure garbage.

Honestly, I really think you may want an extended [f]statfs(), not
some mount tracking.

                 Linus

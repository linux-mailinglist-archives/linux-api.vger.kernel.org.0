Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB05013CDCB
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2020 21:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgAOUKy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jan 2020 15:10:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44257 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbgAOUKy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jan 2020 15:10:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so16980623wrm.11
        for <linux-api@vger.kernel.org>; Wed, 15 Jan 2020 12:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V37Vo/FBhU5kltccCSOcOaOV/u6sTU75u7lgAerRHWk=;
        b=OrYEwmU6lkXsGZWCHNNhtVtpsE6fs3wEj0m6dC3WrtWTeidQt6E9H+zSvKowaPh1ec
         ugRczy3F4djq+5tAM9KSePUrrGy8RTZj+3Nsfw0drc5nlDq0wGY+b9DTqALVC2112QUl
         PU4s1hiA953qkOxsAyvqyWsjNb5gpuGJJ8PeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V37Vo/FBhU5kltccCSOcOaOV/u6sTU75u7lgAerRHWk=;
        b=RBhy6Sb3uSW+ef53j9xgKnKtjesRhffZbK8pvs4//9V83bdrGbabrMEEUbkYBX6/tj
         WTB5OpF/yQD0toQ/3sVdVdr2DCd7nnbtbBmJaGmA2gNUUs1RSjkQ2QjSAsNX3tCHtB4+
         oKYDbMPgtJjk15ICXzkwFxK2ZQ7VkrPj80XCRc9BFkmZIEG35i1gl5tI6W7O2kvqQ1Tj
         DGzT5wcWM13M7NG0hbASfH2WcLSRtxtXDVohbM6BHenSj6A9YdPwbAOhSqAmQzHjWEP3
         anctxV2hIuMtgg+xbqg+XMCszDpw+NXPDYy/lpihtSEuK8xjv8IueEpjP8x270crgJMU
         It9Q==
X-Gm-Message-State: APjAAAVHj/ZqkbvoSPYOEeAF9PwNgVmDZCNE9lA1qN5HsjWGyU6KUUwl
        x7pey5+VdQ9YrOfkSC2HovsUnB/tevE=
X-Google-Smtp-Source: APXvYqzITEXXOQmKJzoIbIH+joaPwAa1k1wUw5HbyrLfpfRt1wKvp5E7rR5XcgMOhGJbnWFhIxsWKg==
X-Received: by 2002:a2e:a361:: with SMTP id i1mr74429ljn.29.1579119050980;
        Wed, 15 Jan 2020 12:10:50 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id l7sm9314671lfc.80.2020.01.15.12.10.48
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 12:10:49 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id u71so19929404lje.11
        for <linux-api@vger.kernel.org>; Wed, 15 Jan 2020 12:10:48 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14mr74215lji.23.1579119048131;
 Wed, 15 Jan 2020 12:10:48 -0800 (PST)
MIME-Version: 1.0
References: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
In-Reply-To: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jan 2020 12:10:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
Message-ID: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] pipe: Keyrings, Block and USB notifications
 [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

So I no longer hate the implementation, but I do want to see the
actual user space users come out of the woodwork and try this out for
their use cases.

I'd hate to see a new event queue interface that people then can't
really use due to it not fulfilling their needs, or can't use for some
other reason.

We've had a fair number of kernel interfaces that ended up not being
used all that much, but had one or two minor users and ended up being
nasty long-term maintenance issues.. I don't want this to become yet
another such one.

                 Linus

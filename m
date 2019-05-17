Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA921432
	for <lists+linux-api@lfdr.de>; Fri, 17 May 2019 09:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfEQH10 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 May 2019 03:27:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42206 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfEQH1Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 May 2019 03:27:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so5918869wrb.9
        for <linux-api@vger.kernel.org>; Fri, 17 May 2019 00:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=vTuqweVxGrMZpBGY8BN5XjnYyQGBYldr7Afqqc1LBhA=;
        b=gd4ihdIX6mX+rvFOVH8yz9+aQdPiPDXRPyGcygBqrDuJPwSH7TN47DMl+ER/tOGyUu
         xlyeywivHbLoa5xLrBhehckK9F+kKqwmeyb4EAZhUHxr2IXUzGnqN6ZesiBIniD6UiYO
         fYiw4LhVzsq7VkATQTviyydJSSmR99+2Vztmr4mkq7vjs+V954+L5HAp+Qk+FH3T8Pdl
         vu3JmTTzSUe6qQo4TffL8iJiaiFOEgGPp1kGOVblJcIyWdgM0xUDvde6K6+e4FN6mOk3
         gdM5vkVzKMUG5dpI3GdBQhdsdVfMqE6HcV4dylRxfvTU1LNMessVH2LAmBI/kYFH50rq
         4UlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=vTuqweVxGrMZpBGY8BN5XjnYyQGBYldr7Afqqc1LBhA=;
        b=J7wZ+vJUgilIopiInGaq0/IDo5AxaEYvUqkaSSgweIEyMrtuXDocDnoW1IfYU7VN9I
         LQ67wFttwVPWDst0kgPs3cukAYfsNaVzU4nkaRwXK5z73VnPRrAoCSA7RGc+SAygkF2x
         yw/4VJZU9jki8YchtR5tVP+XdLSjajW5TgBLaNPTJhy2waYshUF4pkdfTyVoiwuuL1BS
         zrSE/qSyG4bqLQ7/1EFtLXmJ5MXuA6q1MGwxUyi6j/ivAjbO1LUnxhqSiiakybxbMLH+
         DpVxL7NtaAv5aYenmLi3spzXGfpHNN36HzMF6G07HzAHwQUbfigentUDVNNTedjKD31M
         narQ==
X-Gm-Message-State: APjAAAW0KecRRton5LcibFXgZNOdIFsY8W+4rn/C9WrGqDAgs+BNaXoo
        C+WPx6zu3RBFrR8rLHnRI0q5XQ==
X-Google-Smtp-Source: APXvYqxERZsLWFWop9ybQ/EYVH2Iu9qtuOGzCe7d0WdsYyW3c/Na9+Naf3jGBVUUzB8iDnnSnBJN2A==
X-Received: by 2002:adf:83c5:: with SMTP id 63mr4523188wre.33.1558078043966;
        Fri, 17 May 2019 00:27:23 -0700 (PDT)
Received: from [172.18.135.95] ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id c131sm8613450wma.31.2019.05.17.00.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 00:27:23 -0700 (PDT)
Date:   Fri, 17 May 2019 09:27:14 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <11455.1558077206@warthog.procyon.org.uk>
References: <F67AF221-C576-4424-88D7-7C6074D0A6C6@brauner.io> <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk> <20190516162259.GB17978@ZenIV.linux.org.uk> <20190516163151.urrmrueugockxtdy@brauner.io> <20190516165021.GD17978@ZenIV.linux.org.uk> <11455.1558077206@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
To:     David Howells <dhowells@redhat.com>
CC:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api <linux-api@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <16C5B24F-2D1B-4AD3-BFEC-38BE8FE6AE1A@brauner.io>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On May 17, 2019 9:13:26 AM GMT+02:00, David Howells <dhowells@redhat=2Ecom>=
 wrote:
>Christian Brauner <christian@brauner=2Eio> wrote:
>
>> If you still prefer to have cloexec flags
>> for the 4 new syscalls then yes,
>> if they could at least all have the same name
>> (FSMOUNT_CLOEXEC?) that would be good=2E
>
>They don't all have the same value (see OPEN_TREE_CLOEXEC)=2E
>
>Note that I also don't want to blindly #define them to O_CLOEXEC
>because it's
>not necessarily the same value on all arches=2E  Currently it can be
>02000000,
>010000000 or 0x400000 for instance, which means that if it's sharing a
>mask
>with other flags, at least three bits have to be reserved for it or we
>have to
>have arch-dependent bit juggling=2E


Ugh=2E Right, I forgot about that entirely=2E

Christian

>
>One thing I like about your approach of just making them O_CLOEXEC by
>default
>and removing the constants is that it avoids this mess entirely=2E
>
>David


Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EE87A4ECC
	for <lists+linux-api@lfdr.de>; Mon, 18 Sep 2023 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjIRQ1E (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Sep 2023 12:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjIRQ0b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Sep 2023 12:26:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071EF26689
        for <linux-api@vger.kernel.org>; Mon, 18 Sep 2023 09:22:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so5801254a12.2
        for <linux-api@vger.kernel.org>; Mon, 18 Sep 2023 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695054172; x=1695658972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKiCOByDL96hotvveoALRujHhJ+JRMIfwmxKHnT1o6A=;
        b=EnNG+j6nMoA5KaVLnnyVw32zjppQQOD7lHK6ZbT6Kj4Y8FePnCK0wisOnKHhTaZ2qr
         fC0FhB2B2rPlfWZuuhgiznbFl7nb/Xpw0yXjr7HEaeCwNoT0/kdn3IB6H6pJ0NAsZPdM
         I6Tzr+aU5jwo45nfZ30KewF1qcozQzPql4Hfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695054172; x=1695658972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKiCOByDL96hotvveoALRujHhJ+JRMIfwmxKHnT1o6A=;
        b=FxGD/dkvGLjF5zORUpLajjl+zqXd7UyiDHqJkbrmt8v0swddCxc8UpwcOnb/f+T0Lp
         MUeNgEmtX9VHToWZsyPIVX1arwdCM5jTVKzdxr44HYzvPWp/OFV1hTQ1MIL/XWPoTl6u
         j+ze3qC0tXKV29thgTIaYCewgGCVxfaTYsCtJZq9V9NqhqZlfQ7MtgKoPefKrAY6Fw0E
         MtuJmfazBj4btyQvEv/+xA0xgHI2HuGVvqZFLOeftIZjFBzUuUvxBLOQ8kaVMsNQFlQ5
         fs0dbACse7mWtQ4BCcfMwdfS4/lWbXM1iUEzfo1zcu38oZ1mkH66s1yB6rdPApjzc3gv
         l2Bg==
X-Gm-Message-State: AOJu0YzQguZj2ibp2Hgi80sd755K6NYb8qcx+HjgKOHBKCtsImsoGtHv
        ZnqW6GG2O6oSABh26wb/MLTOev3ntID1ObEvbOVNX427aVqs6dli
X-Google-Smtp-Source: AGHT+IFIEvXbEUkU+mxN2F/R/tIeFBRSysj5+zBZP+k60Jl/lHiG5m9DX+A4lurODy2hOWFB3ngj7hncFNBhvH4RRiY=
X-Received: by 2002:a17:906:3102:b0:99c:e38d:e484 with SMTP id
 2-20020a170906310200b0099ce38de484mr8115574ejx.6.1695047562459; Mon, 18 Sep
 2023 07:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
In-Reply-To: <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Sep 2023 16:32:30 +0200
Message-ID: <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 18 Sept 2023 at 16:25, Christian Brauner <brauner@kernel.org> wrote:

> The system call should please have a proper struct like you had in your
> first proposal. This is what I'm concerned about:
>
> int statmount(u64 mnt_id,
>               struct statmnt __user *st,
>               size_t size,
>               unsigned int flags)
>
> instead of taking an void pointer.

So you are not concerned about having ascii strings returned by the
syscall?   I thought that was the main complaint.

Thanks,
Miklos

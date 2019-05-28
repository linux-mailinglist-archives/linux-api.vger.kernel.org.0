Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4529F2D262
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2019 01:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfE1XYE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 19:24:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41967 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfE1XYD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 19:24:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id l25so153393otp.8
        for <linux-api@vger.kernel.org>; Tue, 28 May 2019 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGPN9OjlN0u2vkYT7lUEXn5/y2a9ZsC+Dfozs38xwo0=;
        b=Ot3EWkd25DfNtyqQZi2lKoCMywsWj1GEkyVsamx8IhpKmMYoQlNVtFXDsN5kzZ6ztV
         G0G4l+Yn9BT/91zveLip+MqoiQ9WY7KdLEeUnxKqsGaf/8a6P6TCdXsDzggmJbd8BC7j
         j7g/1ER+6QZ5ydhZ3Bf+DMekuCVU7XQ2krnuSQI+4HCJgoVYtDwKLQjR3UkiqRBl2ZBC
         Hbgfr4g8WcFCgwSmqfiyN+oPogiE52ZKR9MwXWkiESYTJsOEtnnzFKKAjkloisXxqBPE
         +CTyleolaoiiIlj62zgtnI49WL88oeZM7ei1tnil/DaLguKbl4ERfII14rmEY0DmU5Lo
         55/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGPN9OjlN0u2vkYT7lUEXn5/y2a9ZsC+Dfozs38xwo0=;
        b=LaVnviwUI0r+tJu+ufsEXiLWKOU/slYQv4oyaeLPWQ12xAudanYk//rV+0CzzYbyYw
         5HMzeHdNQ2+S373wZBjI60PgwbJY0ynLgxVBwY7dPicNTyaLgmpVZrQ+czSisi72Q/3Y
         bhbGn2q1KxidxFZno77Lw9Ytbp2XXCDsAgeLU/MisJwLFs+RHPsDXqumhie874MstWlH
         o18VQahJmSaN+iVHsXtE6MmnMLLsUtQbl1XYx+v0BHZ89NEiNXgoRSIbKUDUeFZvWHQ/
         mncrDue7CkuRInrD5vAn36VriMchqm0HovwaS6Mjj8caeDwUI94b2EruUYFy6NVYBybo
         NsZQ==
X-Gm-Message-State: APjAAAW3ldVOixfJSaWnNkXaU6Pe/KiWYGXXjNQrmuyvuPYgDPkthEMs
        EuRlNWRRROtG1/soGdvbWqgD6wfszwxI1ol1RSUsuA==
X-Google-Smtp-Source: APXvYqzRVCXeGxin0Tw+MDHx9N4J9nIhwON+HiBvCivgZkw6Vu0lhpKmb1+NRC/UKwUe3iqj0TpzPBIsvDgNEbU7wmE=
X-Received: by 2002:a9d:7f8b:: with SMTP id t11mr5793otp.110.1559085842981;
 Tue, 28 May 2019 16:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com> <10418.1559084686@warthog.procyon.org.uk>
In-Reply-To: <10418.1559084686@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 01:23:36 +0200
Message-ID: <CAG48ez2SAKbPeChAf06GMazMPPThFM+OR00abRZafAP7v+ptKw@mail.gmail.com>
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 29, 2019 at 1:04 AM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
> > It might make sense to redesign this stuff so that watches don't hold
> > references on the object being watched.
>
> I explicitly made it hold a reference so that if you place a watch on an
> automounted mount it stops it from expiring.
>
> Further, if I create a watch on something, *should* it be unmountable, just as
> if I had a file open there or had chdir'd into there?

I don't really know. I guess it depends on how it's being used? If
someone decides to e.g. make a file browser that installs watches for
a bunch of mountpoints for some fancy sidebar showing the device
mounts on the system, or something like that, that probably shouldn't
inhibit unmounting... I don't know if that's a realistic use case.

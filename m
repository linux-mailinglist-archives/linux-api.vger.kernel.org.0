Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2540F409090
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243388AbhIMNxx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 09:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244104AbhIMNvu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 09:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631541034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBjIIvcb5dunWtRsVviIpL9DBOBpPMCvEHR7NyeCpew=;
        b=jVyALL4fF5rGaMeuDIctAKv2DgvLVwcUNFj5A+AglGbMxyGTxN9FEelKQNeLRLd/UGs1Mk
        47F+ItWPYOk+znu0nB49VUz2pHEv1S9C0fljulPHGCr7lO0kk1pIABxAl1RmxfWY61Ehrq
        mL56a7TNTnXw9OF3NuABmssn49yv7VM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-JCmDNYRBO-m12dIc6faDOg-1; Mon, 13 Sep 2021 09:50:33 -0400
X-MC-Unique: JCmDNYRBO-m12dIc6faDOg-1
Received: by mail-yb1-f199.google.com with SMTP id b84-20020a253457000000b0059e6b730d45so12921058yba.6
        for <linux-api@vger.kernel.org>; Mon, 13 Sep 2021 06:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aBjIIvcb5dunWtRsVviIpL9DBOBpPMCvEHR7NyeCpew=;
        b=7oWqBhpl1uG8GU8cs9lMfblkbqMbvF1l6yF3o1/kAjJWYtqufc1miLYHJDSR8qBMBY
         pgTzZ1rhjwc+06km2WN56xuHwhhVelYWeeQpwz8SpwarVfe6PHwM48Dinn7QiL9Q359M
         zzM16buApklwGi7s5rWyh23rJUZpGGgrYh4tIIz0ix7YSvImrk1b8VGzDn3N5KSfpD98
         iP7a/cK4F0u6INLpStXrA5tya8WWOxt5IQySbTtfyM73a5Ea7H5J327O0oOo0ZDxbWou
         VmClTN9uUfh6JbOLAC0dv5YiteQDrf6FKuMp0y/er4SWgVRdbO+OY4iZ0PbZbztUx6Ir
         N5YQ==
X-Gm-Message-State: AOAM530vheveBwafgislv7USgdsFMPl6DHjQ/tS7BXhiow48BF8APraE
        3E9jS9goSS10CmQpSyIDv2sKlSpccWvO5i/9pMcMZf6Rt4CZuXJhymaoB8QCWKzjfvAsE+kLPLK
        QlnzFXYQ+AHyJg7BWglSiK9L1NlP7+H0zfxFv
X-Received: by 2002:a25:6913:: with SMTP id e19mr15482535ybc.25.1631541032795;
        Mon, 13 Sep 2021 06:50:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaynW83umBqEPokVSSibnO6NtuWoQhuE0RyA2lBp5gkMZ2HjvBKRYnpKQf1MqN054h1RGdfDAUtNC2myJBoIU=
X-Received: by 2002:a25:6913:: with SMTP id e19mr15482493ybc.25.1631541032487;
 Mon, 13 Sep 2021 06:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210912122234.GA22469@asgard.redhat.com> <CAFqZXNtmN9827MQ0aX7ZcUia5amXuZWppb-9-ySxVP0QBy=O8Q@mail.gmail.com>
 <20210913102316.GA30886@asgard.redhat.com>
In-Reply-To: <20210913102316.GA30886@asgard.redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 13 Sep 2021 15:50:21 +0200
Message-ID: <CAFqZXNsp84kFLDfJfdu5fboB8vMm85FU7BDDjpiqeiJ2WSjWAg@mail.gmail.com>
Subject: Re: [PATCH v2] include/uapi/linux/xfrm.h: Fix XFRM_MSG_MAPPING ABI breakage
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Antony Antony <antony.antony@secunet.com>,
        Christian Langrock <christian.langrock@secunet.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@strace.io>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 13, 2021 at 12:23 PM Eugene Syromiatnikov <esyr@redhat.com> wro=
te:
> On Mon, Sep 13, 2021 at 09:16:39AM +0200, Ondrej Mosnacek wrote:
> > Perhaps it would be a good idea to put a comment here to make it less
> > likely that this repeats in the future. Something like:
> >
> > /* IMPORTANT: Only insert new entries right above this line, otherwise
> > you break ABI! */
>
> Well, this statement is true for (almost) every UAPI-exposed enum, and
> netlink is vast and relies on enums heavily.  I think it is already
> mentioned somewhere in the documentation, and in the end it falls on the
> shoulders of the maintainers=E2=80=94to pay additional attention to UAPI =
changes.

Ok, fair enough.

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


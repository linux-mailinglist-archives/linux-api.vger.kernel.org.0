Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22CE3CAE1E
	for <lists+linux-api@lfdr.de>; Thu, 15 Jul 2021 22:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhGOUth (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Jul 2021 16:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhGOUtg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Jul 2021 16:49:36 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66741C061760
        for <linux-api@vger.kernel.org>; Thu, 15 Jul 2021 13:46:43 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j5so6239868ilk.3
        for <linux-api@vger.kernel.org>; Thu, 15 Jul 2021 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCO2GLiBjoRD/wTxNrNfCDAnG7zKjv0CL7NTl3BL+74=;
        b=I0MkSo8yM2K5tEzlBDhRnP8YhYapYwdfbBNFzzqqHMrFvY3KrJoIt1Zv/s3ua5Q8ex
         ntJ5Z9JDLZJMZCaZaNyaHVhoPK8QATqokl/URX4D20MFooZGvu2OG4md08rSsbInuSf0
         6G2QWeAffQ7jaJKk8PRAt4dTGySZmcfMdWni0pRNyu5z2C2vXucfH3uWBXRvwVW9aiva
         MTDgq6TeUo1llzWBkL/f+99OYjvpMPbQAYDrOp/ALl05VkDSepaNFWJ2UJWAbxw0bXhn
         fwYAWjIo0HHpBdAjIblq6SySwELzDTQUF96BFd86Hg93eHVFvAwHzZFT7NJ5XqvnPIYg
         cl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCO2GLiBjoRD/wTxNrNfCDAnG7zKjv0CL7NTl3BL+74=;
        b=TXn9q36f7EzaLsP59cZ+Zs8grRsXr9ApQO0ADSN+egEPOVGvfe1/QE3B4Jh3/cZmOh
         F+brEjRzQRPyDkT/Zg7Yi0Ufhy66SjQ3hO89VQUVReIopH0T+kqDdGF4YEd3/FjHBhBd
         2Um+CKYZLaBLYKWF0QuOfU3Ct05U5vYJEwnuTzUuTtnJ+EMO7nx/CgAsUlmpDVHYVUx0
         uNdDuQmcIeoundfHcGdG1585b/CYg382AqmsHdnsG7luSbrzYDwUoKJdvA0dXBITpkI7
         ZlgeQofbXmlKozM1yw/3ldv/cnNnv9ek+FCi4dLRWGXWRiCKsb1Py5HLdbu8WOPsLDMS
         1ajw==
X-Gm-Message-State: AOAM533zYqGZQrI8yilgGxmqOoNrz/zgpteU8BgSZGQBiRZ4ORDb5/Gl
        Bopi+1LCE3DIn6wD7SVBo9QFhtBA+GlcblNn/kds2A==
X-Google-Smtp-Source: ABdhPJywr2YTvdCzA0n7KMwrAbZlhKHlkOtcD1+HT81phD3qBTh8qhlLHL+hqk07V7I3jT92GlaL1q21jZm1sy9a9fI=
X-Received: by 2002:a92:c143:: with SMTP id b3mr3800751ilh.145.1626382002690;
 Thu, 15 Jul 2021 13:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210713013857.3237634-1-pcc@google.com> <cc88a16b-262c-75c3-b7ab-d24a116198a7@gmail.com>
In-Reply-To: <cc88a16b-262c-75c3-b7ab-d24a116198a7@gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 15 Jul 2021 13:46:31 -0700
Message-ID: <CAMn1gO5qBurg3yhT1GG4VEDYw_YqcUWXE95nA6z5-veOvumRDg@mail.gmail.com>
Subject: Re: [PATCH v3] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
 support detection protocol
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>,
        linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 14, 2021 at 1:37 PM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
>
> Hi Peter,
>
> On 7/13/21 3:38 AM, Peter Collingbourne wrote:
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > ---
> > This feature landed back in 5.11, but the manpage
> > update seems to have fallen through the cracks.
>
> Sorry, I don't remember what happened :/
> Thanks for the ping.
>
> > Here's a v3 with the introducing version specified
> > and with one formatting nit fixed.
>
> Please See some comments below (especially in the example code).

Addressed all comments in v4.

> BTW, could you please link to the thread in the kernel mailing list that
> added this feature?

There were several threads (the patch went through several revisions).
But you can find your way to most of the threads starting from here:
https://lore.kernel.org/linux-arm-kernel/?q=pcc+far_el1

Peter

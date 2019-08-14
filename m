Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB98DC9B
	for <lists+linux-api@lfdr.de>; Wed, 14 Aug 2019 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfHNSCq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Aug 2019 14:02:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37855 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfHNSCq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Aug 2019 14:02:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id f17so55569otq.4
        for <linux-api@vger.kernel.org>; Wed, 14 Aug 2019 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GKs5FPWymwQ5gbNZtdTdyRE1Nom6j8+Rxk1X5Ak3ho=;
        b=ux5jbquFlU00xiYhyCHomWd5e32yEqg48ZmXd5Kocjz5nhLaYh6WxI9VNlnCNfdxXe
         Yiip9K8vSXkS/iwxJk5PeIQ1aniVfrXPti8aC2lM/bykilrlvCUl16CRS2nKiJhmNlmh
         CWonW6QNpGzk7nOcd7UR0Zb/ewa6RGZ1S5JFj73exIoBaDEtPZ4R9pSNe4S0BxWBKsYn
         2RqAWQFosegu+aSrRCE5Gt3tAK/jb5qTIhRDF7Ty0EJ3W3EBXWcmX5wuXfXeGMsShLre
         lP9LQKbLCYB17G8cXA7Sgq7qyhzp8TnBxoz+XJ5SDnfoOqDCUh8upgGBhxaqLxoMixrj
         XN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GKs5FPWymwQ5gbNZtdTdyRE1Nom6j8+Rxk1X5Ak3ho=;
        b=iEJRwH5t0xFC5Wv5fBnIOqs+1O/qnC03P/6uEqrN6sLgPh4ux7u48P9tG6mtP7mTJF
         ec3ouvVFzhEJwOkissmhzbfvhZZ8jcCHURuUBnYoJ3QGTH8OM2G5In6/xuQZZieUenjk
         t4hlcqnIFbXJ3a2ekejj6PtTvnJ5Yak4yM09/r9MaIYbSyZkEV5aoKX2DFJSKHWz8zkJ
         vbRTxff0S2QkZnqTV7cSuuMrID849WNk7hR2s/gmRuLfrxfbIbPiJhNnjvM3eA/ByE9q
         sjFx34nToAlvXtI7o/NpFWMmFXwS5V7kW0Utx11WmBGnbnBEbO6MBhfasM0rXINol+VJ
         ebYQ==
X-Gm-Message-State: APjAAAWSKQyIrIqhTVxUCTcoNo4ob/7JfpX870TbZDCi9S8gD5iMfxvs
        G2L8bvqqVOyTC8CTMOa0G66NT3PIZtAc5rioU2OeSg==
X-Google-Smtp-Source: APXvYqzmpHudrjVFaOAaYw4VS7cZnHmFbCJw0EyJVqf5FRTM6F8GCZmq3Mx8zMllZGVFxW/G3bIOgn3IkDXpEgvjxPc=
X-Received: by 2002:a5e:9404:: with SMTP id q4mr1266718ioj.46.1565805764794;
 Wed, 14 Aug 2019 11:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
 <20190808000721.124691-16-matthewgarrett@google.com> <20190814072602.GA27836@zn.tnic>
 <CACdnJuuOhuw71GDwQOrPQxUexpvpZNJocr6m0dYzJw+MMaVKWQ@mail.gmail.com> <20190814174732.GD1841@zn.tnic>
In-Reply-To: <20190814174732.GD1841@zn.tnic>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 14 Aug 2019 11:02:32 -0700
Message-ID: <CACdnJutcF6ZdQKwz7L+i9FUuD8SBsHuhk8rwQpwfDsCpM1y9dA@mail.gmail.com>
Subject: Re: [PATCH V38 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 14, 2019 at 10:46 AM Borislav Petkov <bp@alien8.de> wrote:
> Yeah, ok, I see what you're doing there. AFAICT, you do that in
>
> setup_arch->acpi_boot_table_init-> ... -> acpi_os_get_root_pointer()

Right.

> I hope nothing needs it earlier because then we'll have to restructure
> again...

Passing the RSDP via command line is a pretty grotesque hack - we
should just set up boot params in kexec_file, which would leave this
as a problem for legacy kexec and nothing else.

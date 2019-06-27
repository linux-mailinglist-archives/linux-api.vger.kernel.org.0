Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DF258E6C
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2019 01:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF0XR7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 19:17:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35281 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfF0XR7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Jun 2019 19:17:59 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so8592319ioo.2
        for <linux-api@vger.kernel.org>; Thu, 27 Jun 2019 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ALt8d0AtAjsRjrBD8rKsbA1G2O0Y0X5Cg7cv209nE4=;
        b=aU9s6q0Gw5jxFhUMjcSh770eZamw7jwmsQtPSF3OsojwjJFkj/vdbzg1uaasp6O8oC
         5Lf3Iylyam/fkMhb8IeT/68P8BTYkIsHI7vQ1GPqKc88kecKDHl2WC5/8te3z2WBI0Qn
         GcvLKKGe42nXpXjVYDLUDxBy0h88aHmFLnnxMaBSeVl0DYkoN2HA9rSmkVseW8dwgwZT
         vq+yckoAVxXmA1g0SqgcQ40WeZxmKDNcr597rc7c0Hek93KVhbjPOLKlC3lbT9+wUCJ6
         2ANHgiLq+yJhPrxCs/QctQgXz782a+MotcpW5OxWyVZWuus/ZiT/xHuN/4vSOSGpSROl
         c1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ALt8d0AtAjsRjrBD8rKsbA1G2O0Y0X5Cg7cv209nE4=;
        b=PkAYo/8zhrq5NmewRcuGztTI1SUImaKyXUgRXGkICNrCXMcSSXqOseBM/FwMGIywKm
         KB9u4n9eem+n4OmAm5OtkalElBvSf74wmYNuGLuXEekjQDljuHSrcefvY3WpX31rpoE5
         hJX5sYuihf77KoIwx/bQqzFP6vGmfeqZMMOQ7ZX2CKuOApMPJiVhZ9VU2VXVso3Wahid
         M8BqAqw29QSJU8wfUZudf2oKAa6fcX1HH1YwbopyRW2EvKehQkgwJBwH/bR+nUy7VIX0
         e2RhntfasxHXnUjfdKDnQGD6cjJ7r8zFaluI+qOSrmODeHQ+JrLgXAjhty5+wXf7U3F2
         LQBw==
X-Gm-Message-State: APjAAAXhEASUnfwreI0jm8mQUjzd/c8CRuodk23r+556w7F+uMpRjU6r
        XpKfWV8v8RngnjKjfetLZkSyqrCYBUoxNgN5QaZJmw==
X-Google-Smtp-Source: APXvYqyOUB8xbkKRjPyKPBurKBA+e3hSaS/yPPQW2nJi/+xOea08zQ3i0BDwUHECu+YT1wis6SvkIp+6xGsGO0jzQ9k=
X-Received: by 2002:a6b:8dcf:: with SMTP id p198mr7960681iod.46.1561677478172;
 Thu, 27 Jun 2019 16:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-10-matthewgarrett@google.com> <alpine.LRH.2.21.1906271423070.16512@namei.org>
 <CACdnJusJeCYPKVFHiu6yn+mfqQe5k0RqZhbCUZEkxtXx_shMmw@mail.gmail.com> <alpine.LRH.2.21.1906280411370.18880@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906280411370.18880@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 27 Jun 2019 16:17:46 -0700
Message-ID: <CACdnJuvRtQWFknzxLwKc6erCBZ3+6tXmabEdRuXXGTGrYEAp6w@mail.gmail.com>
Subject: Re: [PATCH V34 09/29] kexec_file: Restrict at runtime if the kernel
 is locked down
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 27, 2019 at 11:14 AM James Morris <jmorris@namei.org> wrote:
>
> On Thu, 27 Jun 2019, Matthew Garrett wrote:
>
> > By that metric, on a secure boot system how do we determine that code
> > running in the firmware environment wasn't compromised before it
> > launched the initial signed kernel?
>
> Remote attestation tied to a hardware root of trust, before allowing
> access to any further resources.

If you use IMA you can get the same guarantees over kexec.

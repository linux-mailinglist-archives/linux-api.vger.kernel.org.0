Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C990458599
	for <lists+linux-api@lfdr.de>; Thu, 27 Jun 2019 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0PbF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 11:31:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36763 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0PbF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Jun 2019 11:31:05 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so5705649ioh.3
        for <linux-api@vger.kernel.org>; Thu, 27 Jun 2019 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuO/waTdEbRopCnF+YINnarVye+qG1Wu8zI6yO1vq2Q=;
        b=nnW95Nc4Sck+SCyLDWb6ekZqtVJR9gFDsyfjGL4qdTmxCKqSDzLNB+q6JY04BCTCox
         rNzxKwwVKDRt6j/nSCWITR4woKO3Bg6Pi4yh4DIx201Y7mmDE2vv9BJlTOgg0nWuLodi
         hRrheHz1Qb7gI7AH1/e+uD16A64/DMlbPbvG0GMFSoHN4QgrKWYC61U11c2JmgwNL4fd
         57IHFuNC5SRqpkx1wImVnhsWW7VQAb4Gj74fRFKt/WKH/hZHSXsN2VBtrqFRwm0yMHvP
         qISmxHrhDrDGrXqYK7CvD9tSjcj8q5EF7ls1Z6zh/pEeXldbhUMy3yPshERw4SLH5ZjI
         zL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuO/waTdEbRopCnF+YINnarVye+qG1Wu8zI6yO1vq2Q=;
        b=G0VDIGaXX7qQ0thORBB0dDcEKd4dCpFIgnuMg6H3OV0cwEy+fb55nRqqZd0ZnjUL0C
         LnS04ahdwALc6yXwBxNNexkQJ5VPudNDYVbhRdJfB61stDylxkxPAp5PrWOTM+tNwQzp
         ddGEHP1U6jL3PkEoJHF1pC3EgP+xRTA2JRircWuUL0OvoCNbYtxnmm+XdRIfBw2yD1iO
         o+p+HLHC6c0UgOuhzJYeBJ05alsHC6N+xwBffQf6iBOdAEXCySdIL+ESmICWYJBT+JjD
         v0g7ck6ANAkXXPBNK/3GvltY12k0B9kPmxfM53BqYu3fInilGq+Hw1p7t91ZJK6D65XG
         Qq+Q==
X-Gm-Message-State: APjAAAXX5B4uTQBJR3M7c2Tgc5wovcZDayShxQzfjTt3/qnRIunLQ3wL
        21uiXNx+2vdoVR7GFZ9P+XUzir+KuBelLiicOyWrqQ==
X-Google-Smtp-Source: APXvYqyWPoDVGM4Ciu+xqxjJUuhEI0J//jkhx4KineosYbAyIwLnim/WCO6ZIrIBAhMlWt7aE44OwKUSv/DF3heQ9b4=
X-Received: by 2002:a6b:b790:: with SMTP id h138mr5109103iof.64.1561649464641;
 Thu, 27 Jun 2019 08:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-20-matthewgarrett@google.com> <87ef3f3ihh.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87ef3f3ihh.fsf@dja-thinkpad.axtens.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 27 Jun 2019 08:30:52 -0700
Message-ID: <CACdnJuuUJShbsDt+oV+2nPOX_pQikOPumtMaB-mas6FLVeZ87A@mail.gmail.com>
Subject: Re: [PATCH V34 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
To:     Daniel Axtens <dja@axtens.net>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 26, 2019 at 6:49 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Matthew Garrett <matthewgarrett@google.com> writes:
> > +     if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
> > +         security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
> > +             return false;
> > +     return true;
> >  }
>
> Should this test occur before tainting the kernel?

Seems reasonable.

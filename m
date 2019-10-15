Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D27D837F
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2019 00:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfJOWVI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 15 Oct 2019 18:21:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42010 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbfJOWVH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 15 Oct 2019 18:21:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so15723088lfg.9
        for <linux-api@vger.kernel.org>; Tue, 15 Oct 2019 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igJfeABa6M5mmcDSZ9XAWyfxDlpeT34TBKS5Vu4WYQ8=;
        b=LIYdbK/WEFGMNdD+uIGw2BasCdPDikOSk/1C31c/6KJAoWeweWvBbkEnJF4PHN8TkH
         BgZdUCf/ZYXj115hlOqd/koyMkdZG6Il9yGalmukOiV4kTIOYCVZSlLQpLqR2NWtyVYg
         nGZ/n1OZmV0DBw+aQ4pzCSwYlzFEdDM+SUZEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igJfeABa6M5mmcDSZ9XAWyfxDlpeT34TBKS5Vu4WYQ8=;
        b=X8D6TXY4QtbmtaOSxkWvGOv1386j8DzkqF2oG9Pw7k8GrLfF4IsDjufG7TM9XV4X4p
         x8IYnMt8d0g6KpI0854WqCCb1Ar2z4kVXAHxlvqjtxKWiaH3KOkB1g9mlPOcOCdOL4CQ
         WQnnt2STeNaXih2aPhyH/ZbO2cQYK4A0HKvY+rpQYIk6QF0bLkQOveky+kwnGzr1NsVs
         eX3dKz/u6KG0QCXQdRUxxBxVbtTMmDP0fSMDJEktI0E9znbStL568AGYxYAcpDLdTNgt
         3phYhgGOCKyjLjHbpLWLWVdKo8LQ39D0WfbG7am0o0+ZnW4OVwWSvw4Jvx8mSB2b2pCH
         SZ3g==
X-Gm-Message-State: APjAAAXprJZuVZTTzKqG1CUcLDMypjoSib+S9DiHldQO3Ve1cfLEODMu
        vfr9AYLJfljMxPU86es9mGiTAj/fPvs=
X-Google-Smtp-Source: APXvYqwFhF5wjmFksWla0Oi4DlfQM417ev06O/olq+2XBw5O1mrZy1vaGA6FUHCWBHBYGjbiJhVk0Q==
X-Received: by 2002:a19:ad4a:: with SMTP id s10mr22162594lfd.159.1571178066294;
        Tue, 15 Oct 2019 15:21:06 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n25sm5194646ljc.107.2019.10.15.15.21.03
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u3so15720947lfl.10
        for <linux-api@vger.kernel.org>; Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
X-Received: by 2002:ac2:43a8:: with SMTP id t8mr22573654lfl.134.1571178063150;
 Tue, 15 Oct 2019 15:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
 <157117614109.15019.15677943675625422728.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117614109.15019.15677943675625422728.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:20:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivjB8Va7K_eK_fx+Z1vpbJ82DW=eVfyP33ZDusaK44EA@mail.gmail.com>
Message-ID: <CAHk-=wivjB8Va7K_eK_fx+Z1vpbJ82DW=eVfyP33ZDusaK44EA@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] pipe: Check for ring full inside of the
 spinlock in pipe_write()
To:     David Howells <dhowells@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
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

On Tue, Oct 15, 2019 at 2:49 PM David Howells <dhowells@redhat.com> wrote:
>
> +                       if (head - pipe->tail == buffers) {

Can we just have helper inline functions for these things?

You describe them in the commit message of 03/21 (good), but it would
be even better if the code was just self-describing..

           Linus

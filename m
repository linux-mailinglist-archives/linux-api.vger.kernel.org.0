Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DBA6B255
	for <lists+linux-api@lfdr.de>; Wed, 17 Jul 2019 01:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbfGPXWv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jul 2019 19:22:51 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39827 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbfGPXWv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jul 2019 19:22:51 -0400
Received: by mail-vk1-f193.google.com with SMTP id o19so4567750vkb.6
        for <linux-api@vger.kernel.org>; Tue, 16 Jul 2019 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjpiai5hkCYLL6Diojv89YWK7LVysGGzfUoUrfBoeQ4=;
        b=RpCqwPCvhvOPAtlSlatjK+atlcOC50FQcSClS0zKZgzBPDO/DW9MiVWDoZF58z5MdB
         fnyNbMK3RMD8HWeS3xtOcaJ5UaNwSop31ZerBzqTWC0XCvKIsd1S8s95vHljNbcIZWXE
         fI5qKOqIfdpP3Hm/+0L6i62IX70ZMgzJc4HqcoGlLbXi3l0P+f6a+f0T1CMKj356LoWd
         mH1CD9c8Pr7oWbnQkDunKHAZE7tI6iiPcWQyHiGGYiNIZQhRWEAvw4YNZho4wxeVkn8U
         AVpyxNe1w6+FrA59cJIayB2b/wKm+AVSzszC68evKv0kBMXA36YaJRP0LTi1WGRp4Zfu
         oi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjpiai5hkCYLL6Diojv89YWK7LVysGGzfUoUrfBoeQ4=;
        b=ei4a4RZcoe4CYX4jNcFMHQip9nhmXZuE8Wv8asZq68k2BB6rkVgti0SlIL/RZULHPy
         TQSfmQw8IE8U/VkmtbQJqM0XvUA2ogph++D66DWmLpqYmPl/0207QtgRDxwvUTrw6BRY
         J6mIEmxuMYwOUApi/mMrZO3EVqFLYNbFaefjaHhiPLBeXmSvKUqRFVeUOAxoktefklrn
         RGQIJG4bb8yDC9xzM/g1Obi7v0dTeSNnYpF8Nv9t+frKunUhslNR82jvHfWUXAmVsP3w
         Kx+APJeOoqmglWUeV+LrxNHdOyhPGXeQy8JkF90hUP6RTzLXfb2Vi0V72lIC1kj2TRiR
         qUsQ==
X-Gm-Message-State: APjAAAU8bsTikO+BnXVpX8tgCFAWWQ4jRPU+AYsSkFMfwBmPuvcEZADs
        CbI0PeEZnu8LZYyClKie9s2sURfdKWadMXaPw3RY0g==
X-Google-Smtp-Source: APXvYqypcm143UE8WXo2p4xQIYE4/nSLIYw9Jmalgee0YoQ3TxaTvtAIBcOrWMDEUoeTN8IBjeyCTb/bN9WDKfiOz14=
X-Received: by 2002:a1f:3dc1:: with SMTP id k184mr13794381vka.24.1563319369484;
 Tue, 16 Jul 2019 16:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
 <20190715195946.223443-28-matthewgarrett@google.com> <20190716191439.59a1ac32@gandalf.local.home>
In-Reply-To: <20190716191439.59a1ac32@gandalf.local.home>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 16 Jul 2019 16:22:38 -0700
Message-ID: <CACdnJut3FDAqpELYOicR9-tYCF+G_213J0nGJHeR5EPqXqToVg@mail.gmail.com>
Subject: Re: [PATCH V35 27/29] tracefs: Restrict tracefs when the kernel is
 locked down
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 16, 2019 at 4:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> Small nit, but please add this as the first declaration, to keep the
> "upside-down x-mas tree" look. I know some of the other functions in
> this file don't follow that (which should be cleaned up some day), but
> I'd like to avoid adding more that breaks the aesthetic of the code.

ACK.

> > +
> > +     if (fops)
>
> I think you meant "if (!fops)".

Blink. Whoops! Yup.

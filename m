Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34FC34B40F
	for <lists+linux-api@lfdr.de>; Sat, 27 Mar 2021 04:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhC0Djw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Mar 2021 23:39:52 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:46867 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhC0Dja (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Mar 2021 23:39:30 -0400
Received: by mail-ej1-f51.google.com with SMTP id u21so11240764ejo.13;
        Fri, 26 Mar 2021 20:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzvQOdiTuJn91EksSWxSV9lMXnSkfJJHPv+wvQk24Fc=;
        b=RcZ5Y0+kvdwYLz9v8PrcrOO/2JutvaIHwDlLmhO7RbsdFP01vgK+5sv6k50O2ZmSE6
         GLdHGKiAEKHBL+hCyI9zKCg0T27pZYLLfBfY93tblH/PzG0zweItJPCD5Za1wz7J4dyr
         KXqXhppR2lWPi1RiPEe3gwOEV57x+IYu3aPMK3ptcBiubMPNPH+fmXDhMl1pO1mvzPhP
         SmVaYufktp1IlIhNUV5tYDcQTgGVIqRAaQ1sVpIndrL23ELnq4lgD5YPSebIdkybhPW9
         sV28h+COqc44FWER/HbMH4f3vrACnh6WLkKxxycMlxfReZY2A1Uehq5UEh/nDzfkRmrW
         Z8aw==
X-Gm-Message-State: AOAM530yx+Jvgwqk8F445+6wXH6aepVfSbo+MoTUzng3k7K5YycJSN6T
        rF4lnouaTul8b9+Dqdo0aznxgK+JRJjwxZZeRHM=
X-Google-Smtp-Source: ABdhPJwWxt8BzcJhw62HhnCoY8jvVcNBvycyHZf/oX0G8chnrC+GE5egCZfeXc3pmhojkszhDtlA+FYh67mYZckinYA=
X-Received: by 2002:a17:906:b4c:: with SMTP id v12mr18535870ejg.330.1616816369239;
 Fri, 26 Mar 2021 20:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
In-Reply-To: <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 26 Mar 2021 23:39:18 -0400
Message-ID: <CAJvTdKm8aQPwQMXFQWgVb5dfJ88ds3d0=uHOyWeueUqfya9Nsw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andy,

Say a mainline links with a math library that uses AMX without the
knowledge of the mainline.
Say the mainline is also linked with a userspace threading library
that thinks it has a concept of XSAVE area size.

Wouldn't the change in XCR0, resulting in XSAVE size change, risk
confusing the threading library?

thanks,
Len Brown, Intel Open Source Technology Center

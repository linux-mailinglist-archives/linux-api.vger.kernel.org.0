Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BED281862
	for <lists+linux-api@lfdr.de>; Fri,  2 Oct 2020 18:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbgJBQzT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Oct 2020 12:55:19 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:45848 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBQzT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Oct 2020 12:55:19 -0400
Received: by mail-oo1-f65.google.com with SMTP id h8so498155ooc.12;
        Fri, 02 Oct 2020 09:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8acJid1D+NJC+ex0YodQOTm9oogbBy0h06gU04aC0XY=;
        b=JRPyZGJCt0fT8QC419QRIS2vXzHhyrrIbUwkjM5I+owYOkUYVyxIsQMIjswUcuxO1I
         NuL1RR2M5oYysSGysrhYcy4dCmfcZXdJZKjVIYDsk9Z7Ivkh7/TH/5KmiEJPxR4AXXSZ
         pLmqkKuwFh63OIDcoVq/hMQ0hf9wCpq1BHaUL/COO6vwfI9cxxX8O71Yrlw73++OY85v
         AahmK++zN3TQZRx4IranLTYGzv4mVICmtc1pf2fSLN1XYglrdfplm5kryigqUTLr2vWo
         SIHCv3486VNI5wsYgrQfEyCkQB+rRfD2XsL8vZ+RG9R/z4T2+qofo6Y2mjfBgH2v8Zqo
         r9cA==
X-Gm-Message-State: AOAM532e7QvAr7hUmtqFG9t4mJWMiYByoSb2jVF25Xx4g533hXtg1Dg4
        9oxqv6Fq9d2h6hANjIvJGrUSNEPM5d1z+IsG5wQ=
X-Google-Smtp-Source: ABdhPJwZUqG9hHnok6yLqSy68HWB+jGdIfkMO9LgBruMFrfKI+a59EUTUicSwMUusqw5ZgzGMiryMveJdWirBIO3Ikg=
X-Received: by 2002:a4a:e946:: with SMTP id v6mr2586023ood.38.1601657717839;
 Fri, 02 Oct 2020 09:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200930140547.840251-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20200930140547.840251-1-Jonathan.Cameron@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 18:55:06 +0200
Message-ID: <CAJZ5v0hUPk6Geh3MG+948Q_LmHNEYBoJgBKLFb7jH7RCbPv5PQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] ACPI: Support Generic Initiator proximity domains
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 30, 2020 at 4:07 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> It would be very nice to finally merge this support during the next cycle,
> so please take a look.
>
> I think we need acks covering x86, ARM and ACPI.  Rafael took a look back
> in November at v5 and was looking for x86 and ARM acks.  Whilst there is
> no ARM specific code left we probably still need an Ack.  If anyone is
> missing from the cc list, please add them.
>
> Introduces a new type of NUMA node for cases where we want to represent
> the access characteristics of a non CPU initiator of memory requests,
> as these differ from all those for existing nodes containing CPUs and/or
> memory.
>
> These Generic Initiators are presented by the node access0 class in
> sysfs in the same way as a CPU. It seems likely that there will be
> usecases in which the best 'CPU' is desired and Generic Initiators
> should be ignored.  The final few patches in this series introduced
> access1 which is a new performance class in the sysfs node description
> which presents only CPU to memory relationships.  Test cases for this
> are described below.

The whole series has been applied as 5.10 material.

If anyone has concerns or objections, please let me know ASAP.

Thanks!

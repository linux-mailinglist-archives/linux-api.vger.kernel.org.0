Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC82B19410
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 23:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfEIVGX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 17:06:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40247 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIVGX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 May 2019 17:06:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so1824820pgl.7;
        Thu, 09 May 2019 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwdM2UMyaoGs3iIpEHT4wikyqYXOBwn5Ujry1Qy8uJE=;
        b=KmXkJVqBK7LAOIDQ6+WnLGtJMzDVrJ3LOkPeuv03XH5w0r+S46N+MA30htSp3updGC
         K8M3ntGrIRKAkldyF5E9pTKQ/gNpUwWU58JZPfcrMT5ClGvSUiDIn5xeEMH3xoiMe0eD
         i+NIxVgqVISJSpw2vJl4pvZ9XaN+nU8wkamEmXsZlE8vXh6eZyvt6bPaxEdo3R4AXY7a
         rJb2EMYMJggpqx7Cfrrg3eGINUvVOpDt7Ccekwm6lflsgkjq6rrHW7rXbvi87m4RfNJt
         IclOHp5o1g9QJcEjRvaEWoQBUWkoZjMdTm1CG4/PU0WJ+7xXq/U9WcI8IcwSfU1jbLs6
         VdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwdM2UMyaoGs3iIpEHT4wikyqYXOBwn5Ujry1Qy8uJE=;
        b=uU2J5h5tckKKucsGm3Aqwg9q1J3/ZnzBmTnKj7CVbiUk1q54rvUuzH+OCTwkr+CgDy
         QZQzFMmjZeB/6WPKL9LmdJ93ONM1MAuaa7Y6ZFOJZNbp8mjRbwg4hgn02hoi/AcqM+JX
         HZT+CDu7sWU3HEPxEspcqL4Oagl/uEn9rdUJivNhuYNzGHvNZSwKuhqRdwzVDYyZqiTX
         4iFXM7+KAP/pj9nK+64GbnkMExxhKHrA0jL1OxLyTFAgLJd8W3/bj940RME9pgcZPaZV
         4uBmJe7TezpmWGgeBwm04azXZTIssXOPtOfghHnpyjhByxD0X08QtHPc0mDxmuU1Vo2z
         IkMQ==
X-Gm-Message-State: APjAAAWrTXL/q42AlE9iAo+4q0cnERHzV0BPtoU30YAdhY7p+LkzC0kB
        hAoY6/q8IjcFaziWe4mir/dTYtIB0XMPhx5rvSc=
X-Google-Smtp-Source: APXvYqzf58xdfv93OGQavZZgXltBWj15CC/mfJ9scyGnvZe3+sapx9YsoxAjL1TAdMG2M/WCTb1bXXnLLfs3NJaPzA4=
X-Received: by 2002:aa7:8212:: with SMTP id k18mr8433455pfi.50.1557435982742;
 Thu, 09 May 2019 14:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <c953b43b-6186-77e9-54b1-b1cd1d7d1eb6@gmail.com> <CAHp75Vf9uPG7_K0P26nHYCH0WB6LFX3wk8aJBpLWQ-r46kDw9w@mail.gmail.com>
 <20190508171229.GA22024@amd> <52e73640-9fbf-437b-537a-7b3dc167052f@gmail.com> <2f26dd9e-ada7-8e20-c810-a647854c338c@ti.com>
In-Reply-To: <2f26dd9e-ada7-8e20-c810-a647854c338c@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 May 2019 00:06:11 +0300
Message-ID: <CAHp75VcSVumVg74==bM3cBcZZ2iUNDnUao6h9Q6ktcyEuAKDew@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] platform/x86: asus-wmi: Control RGB keyboard backlight
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 9, 2019 at 11:45 PM Dan Murphy <dmurphy@ti.com> wrote:
> On 5/9/19 2:04 PM, Yurii Pavlovskyi wrote:
> We are working on a framework for this.
>
> Please see this series
> https://lore.kernel.org/patchwork/project/lkml/list/?series=390141
>
> It is still a work in progress

Side question:
Have you considered to convert existing color LED controllers? (It
seems to me that your proposal lacks of the idea to keep back
compatibility with the existing controllers whre user may create a
sysfs node based on the arbitrary label, while it's good to have
multicolor infrastructure like in your proposal. Did I miss
something?)


-- 
With Best Regards,
Andy Shevchenko

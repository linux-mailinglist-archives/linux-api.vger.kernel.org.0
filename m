Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567395858D
	for <lists+linux-api@lfdr.de>; Thu, 27 Jun 2019 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF0P2V (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 11:28:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39518 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0P2V (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Jun 2019 11:28:21 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so5648356iod.6
        for <linux-api@vger.kernel.org>; Thu, 27 Jun 2019 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3RhI9DNvqsR2Iknx3LGGvk1u88PumHwEAJh9YfsKq4=;
        b=gekKU/tGlO7Mg0UGCOLXXY+Ire65Q4Z2qg5wd1h/tWU9dzP0OjY9RAukwLeQIBSiqO
         lOzOnp3OUJGMVLjCBBaxpYTOR7n0lu7pDCECDHHB+ew+MrRhPUsJ0/NzKMwdsdcqH0Ov
         7lUBWw8BNh134qpS92lj0nucRNsTHYxeobnt31H/hqDGy9ghty4FICuN8yjUcc9NWF/6
         905EiAC6mqg4SnIM0fMAjsXUMLsqln3Od29lkC8l+/yuWFoRGhklNh7wu6HdgobanftQ
         uCGE/qdCkvuTW0BOqRXIuGm5aMHPy5aZt2n/GNm5dIfAcnbAFzKIOR34tkMtJDQm0I8O
         xIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3RhI9DNvqsR2Iknx3LGGvk1u88PumHwEAJh9YfsKq4=;
        b=UYQyyXKYyTjY4z2s0i7fFdAf/CigWjE+AlT0HT/EAlnu58jn3ba/KT1bVc7bbF0pFt
         DWpVExbHomaqKxvqXX4/pZaercJkRMHP6E4fpFEfCBeKw+tTSvE3aImOlpsY286g1l5K
         He8DwFFbwJylCTot3MHjRhOamh8jsngWxh80CDFjWcTaDy/+hkjR2m10fFFEselzMmpa
         UOjS57V7hBIkgBrOPP/7rhdWHAZztDMRqN/Uz7v8MT7Wl8Gz+j98ftIQLS/1h4sQFw5N
         3ukn1rUEB5l/AOgP4fFIlKGbNM0xgfWOwq9E9FH2zVIfgFg0SjtbP4LLq9OnX9u1TUOZ
         8Vtg==
X-Gm-Message-State: APjAAAVNsGqAAMtwtAfwCqGQIoc3s+rC+WhFJuW8bOCovJWYeq+q7eu1
        nU6L+PJjAFWdfZe5tCgsDlH6Rk/uG7CorbtVdOclSA==
X-Google-Smtp-Source: APXvYqxt+k0Ai9dyDn8LZuqnNMawxVvBOa3fPtlRblTKZbcATMFln2wqMn2SYedj7jJBGVi/ao2H/uL/Z68ruv8rRdU=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr5395263ion.204.1561649300148;
 Thu, 27 Jun 2019 08:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-10-matthewgarrett@google.com> <alpine.LRH.2.21.1906271423070.16512@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906271423070.16512@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 27 Jun 2019 08:28:08 -0700
Message-ID: <CACdnJusJeCYPKVFHiu6yn+mfqQe5k0RqZhbCUZEkxtXx_shMmw@mail.gmail.com>
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

On Wed, Jun 26, 2019 at 9:59 PM James Morris <jmorris@namei.org> wrote:
> This is not a criticism of the patch but a related issue which I haven't
> seen discussed (apologies if it has).
>
> If signed code is loaded into ring 0, verified by the kernel, then
> executed, you still lose your secure/trusted/verified boot state. If the
> currently running kernel has been runtime-compromised, any signature
> verification performed by the kernel cannot be trusted.
>
> This problem is out of scope for the lockdown threat model (which
> naturally cannot include a compromised kernel), but folk should be aware
> that signature-verified kexec does not provide equivalent assurance to a
> full reboot on a secure-boot system.

By that metric, on a secure boot system how do we determine that code
running in the firmware environment wasn't compromised before it
launched the initial signed kernel?

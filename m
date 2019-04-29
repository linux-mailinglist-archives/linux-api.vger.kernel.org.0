Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121F1ED10
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 00:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfD2W45 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 18:56:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35477 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfD2W45 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 18:56:57 -0400
Received: by mail-io1-f65.google.com with SMTP id r18so10543110ioh.2
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gygjGy0Tx6m/3bovClGd2rLBa0pi6fNkHAIxfSZ8kUM=;
        b=AF2He1xZrzkq68YRqvXpoaCfGbxnrVNa2SJu9UdF1Z6AYKHNfcloWp1li3hqdeB8Yw
         MMLLDS6kIn076fI1Wk86rvhdrAp3CTIc33eVG/u/H06seb031gy2PyWw/pSUSCpXqcs4
         QHWbCKbbkFGOAuP4i2ubnx/2+0b5W+Z3rkMYDMSUq1gvH1tfWVKTYKsR2k7Kmc91wGlR
         P5edMWkg5ant75Z611KNqa0EZJGvVW9z+435VcX94/x/UQIxv6XKzHiP+mMarsqSwTVQ
         le5Aa1ygiTZrQTZWiRMmP7I+cjqXXVUxk9fgBwc7Mmcgsum9SlhUFBYDXshYBzqR4xyK
         569A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gygjGy0Tx6m/3bovClGd2rLBa0pi6fNkHAIxfSZ8kUM=;
        b=ZiUMY+qLZp6OyOBGhOe/p3hAAy6VNYIabymeuzc5n4zwq+nZeSV9CgkSsFse7WhSyD
         HoXK4BmgcSMHCNWE+NhHWr0jsoH6wsndqO9wmCLHmS/afrWLmpTAjgZfvlFcisPcNgUP
         ixI1Z+4cxFS+XRdY4lQdAseWZIvzgwVZ5t/rjtc0vxKypNaJUZ34BCt7QY6aqtgZ5Hvw
         +4RBcJ3fOj1vaetsdidJKVPgFxIkCk4NuYjWR7go/whC9jh0+sk4HUNlBjtXAQ813qQO
         ocSamhuaOYKEk69NBpI38HcJvvk2iA+MsnrR1+QU1zHszs0buq3UTMWR60M/ZCRMsU3+
         qZ3w==
X-Gm-Message-State: APjAAAUZYL25T9DomLOa3XoR9Z2YcqCKENG/EE+S0szVE16KkNGhu74t
        kjPHQ5UTX08X5WYsDwraCnMuOU5gzqcRGnCihxNLlQ==
X-Google-Smtp-Source: APXvYqwELCQYSYxRolEnxOwvku+vu6EGCFx5Boay6oC9nRGmg6H97OlakZWLGo8xgn/GBDkG5aLRGbOMS5HGrk//aDw=
X-Received: by 2002:a6b:e20e:: with SMTP id z14mr6314345ioc.169.1556578615904;
 Mon, 29 Apr 2019 15:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com> <20190404003249.14356-2-matthewgarrett@google.com>
In-Reply-To: <20190404003249.14356-2-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 29 Apr 2019 15:56:44 -0700
Message-ID: <CACdnJus-+VTy0uOWg982SgZr55Lp7Xot653dJb_tO5T=J6D8nw@mail.gmail.com>
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi James,

What's the best way forward with this? I'm still not entirely clear on
how it can be implemented purely as an LSM, but if you have ideas on
what sort of implementation you'd prefer I'm happy to work on that.

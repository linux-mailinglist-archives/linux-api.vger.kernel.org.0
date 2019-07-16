Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F296B073
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2019 22:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfGPUcp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jul 2019 16:32:45 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43958 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfGPUcp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jul 2019 16:32:45 -0400
Received: by mail-vs1-f65.google.com with SMTP id j26so14859708vsn.10
        for <linux-api@vger.kernel.org>; Tue, 16 Jul 2019 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81NxWyaYYLOx3U0CNAY+vem2FwAQtGrb2n7o/OCCQ6Q=;
        b=EzQNWrBC5qDZZtG/w0lKikRR/oNojiw9cBTeaFyF+wRtC0dUeoMDAVmJAyqgyBzSEe
         NnHR+bKb6u1SnmKae3PIH+umXwHZMHtFajbm/8e/0FKjLrjds+MrgdBNWGVgxTk/yr6r
         a85dbUuIp7o5N3v/8tNZHHWO3WTJG2qgU7hh2JmzThDmC4LWVEqOIQxnLnkYtDSCe2ti
         5FQhqEyqvKKdQWNiHM1ecC46U6rAWhmCVAaC9TfrC8eScLAfgKAcSwq1bSAoiEmgzGkY
         v9jXDgZ1Ero5tUf69xUGxmjRwnF44LzOVHGe3Veh7QYw4fFvqvGOrUYAfq8zFdebhPQT
         bgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81NxWyaYYLOx3U0CNAY+vem2FwAQtGrb2n7o/OCCQ6Q=;
        b=qC0Lthi01V+6HU1ZNUJSzUyELYNL2N3cvaBqhRM8bH/MN90t1JohjUD1/mefdx1Gmz
         yuG33rEqn2HUh0zjO0QqrwzgR4IJZrbKmnnH8veQcDChweEq37UKMNWSxN6gb1Gyd2LQ
         XL5dlT7HCou6/wcT47b1fx6fCeKDaIg92Nkdm1glJ8sCBr8X9CdmAdE8ZKwLkQuznxWO
         uvKia9UGaT9NwFRKebshQTYSJU4s83lQM9nxKxehkMJJQpXijOgXUQcKvD4gflvG0Ft2
         /enAmpfLRojNGYYH57h6S1i46bovkm7/2jIvrYSQvtxRBcaN+WFly7d7GywxN/MHH3Of
         zAkA==
X-Gm-Message-State: APjAAAUYl9HjDxlR44+grXTUpWOKGOqIhwMwC76ixy5s2yraEvTsrr7Y
        +ikN+HRBtKPKRY5mgCDG3q8uxCuKWlp5Yl+YJlRb6Q==
X-Google-Smtp-Source: APXvYqxQj6V0JsV1Wq1M4PK/ZqnLQAggZqvxwAWQtvoVxjTqMsgvXgRRn/MxQo0FX6SkSFdhHPKRHE9oRdeF58llyro=
X-Received: by 2002:a67:fb02:: with SMTP id d2mr12106614vsr.207.1563309164025;
 Tue, 16 Jul 2019 13:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
 <20190715195946.223443-24-matthewgarrett@google.com> <5d363f09-d649-5693-45c0-bb99d69f0f38@iogearbox.net>
In-Reply-To: <5d363f09-d649-5693-45c0-bb99d69f0f38@iogearbox.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 16 Jul 2019 13:32:33 -0700
Message-ID: <CACdnJuudpnaQ5YUhoxmxNWVdRB6v0u0Bf2O6NmYOXjp8_govyg@mail.gmail.com>
Subject: Re: [PATCH V35 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 15, 2019 at 3:54 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Hmm, does security_locked_down() ever return a code > 0 or why do you
> have the double check on return code? If not, then for clarity the
> ret code from security_locked_down() should be checked as 'ret < 0'
> as well and out label should be at the memset directly instead.

It doesn't, so I'll update. Thanks!

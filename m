Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB0425410
	for <lists+linux-api@lfdr.de>; Thu,  7 Oct 2021 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbhJGN3I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Oct 2021 09:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhJGN3I (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 7 Oct 2021 09:29:08 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69E9561058;
        Thu,  7 Oct 2021 13:27:13 +0000 (UTC)
Date:   Thu, 7 Oct 2021 09:27:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zack Weinberg <zack@owlfolio.org>, libc-alpha@sourceware.org,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, mtk.manpages@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 16/22] futex: Implement sys_futex_waitv()
Message-ID: <20211007092712.1884d1b3@gandalf.local.home>
In-Reply-To: <20211007090837.GQ174703@worktop.programming.kicks-ass.net>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
        <20210923171111.300673-17-andrealmeid@collabora.com>
        <20211006115022.GH174703@worktop.programming.kicks-ass.net>
        <47b13460-27a4-474c-879b-ed1c668e5923@www.fastmail.com>
        <20211007090837.GQ174703@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 7 Oct 2021 11:08:37 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > 'wake events' is correct here, but you introduced an unrelated error:
> > 'loose' is the opposite of 'tight', you want 'lose' with only one O.  
> 
> I shall forever make that mistake :-(

Don't lose the loose moose goose ;-)

-- Steve
